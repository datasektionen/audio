#[macro_use]
extern crate rocket;

use rocket::fairing::{self, AdHoc};
use rocket::fs::{relative, FileServer};
use rocket::serde::{
    json::{self, Value},
    Deserialize, Serialize,
};
use rocket::tokio;
use rocket::{Build, Rocket};
use rocket_db_pools::sqlx;
use rocket_db_pools::{Connection, Database};

use std::collections::HashMap;
use std::env;
use std::fs;

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
struct Song {
    id: String,
    title: String,
    alttitle: Option<String>,
    firstline: Option<String>,
    meta: Option<String>,
    text: Option<String>,
    notes: Option<String>,
}

#[derive(Database)]
#[database("audio")]
struct Db(sqlx::PgPool);

#[get("/songs.json")]
async fn get_songs(mut db: Connection<Db>) -> Value {
    let results = sqlx::query_as!(
        Song,
        "SELECT id, title, alttitle, firstline, meta, text, notes FROM songs;"
    )
    .fetch_all(&mut *db)
    .await
    .expect("Failed to read database stuff");
    let mut map = HashMap::new();

    for song in results {
        map.insert(song.id.clone(), song);
    }

    return json::to_value(map).unwrap();
}

async fn run_migrations(rocket: Rocket<Build>) -> fairing::Result {
    match Db::fetch(&rocket) {
        Some(db) => match sqlx::migrate!("./migrations").run(&**db).await {
            Ok(_) => Ok(rocket),
            Err(e) => {
                error!("Failed to initialize SQLx database: {}", e);
                Err(rocket)
            }
        },
        None => {
            error!("Found no database!");
            Err(rocket)
        }
    }
}

async fn insert_songs(rocket: Rocket<Build>) -> fairing::Result {
    let Some(db) = Db::fetch(&rocket) else {
        error!("Failed to connect database");
        return Err(rocket);
    };

    let Ok(Ok(json)) = tokio::task::spawn_blocking(|| {
        fs::read_to_string(relative!("songs.json"))
    }).await else {
        error!("Failed to read the songs.json file");
        return Err(rocket);
    };

    let map: HashMap<String, Song> = match json::from_str(&json) {
        Ok(m) => m,
        Err(e) => {
            error!("Failed to parse the string: {}", e);
            return Err(rocket);
        }
    };

    for (_, song) in map {
        let Song {
            id,
            title,
            alttitle,
            firstline,
            meta,
            text,
            notes,
        } = song;

        let res = sqlx::query!(
            "INSERT INTO songs (id, title, alttitle, firstline, meta, text, notes) \
             VALUES ($1, $2, $3, $4, $5, $6, $7) \
             ON CONFLICT DO NOTHING",
            id,
            title,
            alttitle,
            firstline,
            meta,
            text,
            notes
        )
        .execute(&**db)
        .await;

        if let Err(e) = res {
            error!("Failed to insert song {}: {}", title, e);
            continue;
        }
        info!("Added {}", title);
    }

    Ok(rocket)
}

#[launch]
fn rocket() -> _ {
    let mut figment = rocket::Config::figment();

    if let Ok(url) = env::var("DATABASE_URL") {
        figment = figment.merge((
            "databases.audio",
            rocket_db_pools::Config {
                url,
                min_connections: None,
                max_connections: 1024,
                connect_timeout: 3,
                idle_timeout: None,
            },
        ));
    }

    rocket::custom(figment)
        .attach(AdHoc::on_ignite("SQLx stage", |rocket| async {
            rocket
                .attach(Db::init())
                .attach(AdHoc::try_on_ignite("SQLx Migrations", run_migrations))
                .attach(AdHoc::try_on_ignite("Song reading", insert_songs))
        }))
        .mount("/", routes![get_songs])
        .mount("/", FileServer::from(relative!("build")).rank(20))
}
