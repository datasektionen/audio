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
use serde_with::{formats::PreferMany, serde_as, DefaultOnNull, OneOrMany};

use std::collections::HashMap;
use std::env;

#[serde_as]
#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
struct Song {
    id: String,
    title: String,
    #[serde_as(as = "DefaultOnNull<OneOrMany<_, PreferMany>>")]
    #[serde(default)]
    alttitle: Vec<String>,
    firstline: Option<String>,
    meta: Option<String>,
    text: Option<String>,
    notes: Option<String>,
    partition: Option<u32>,
    page: Option<String>,
    page5e: Option<u32>,
    #[serde(default)]
    tags: Vec<String>,
}

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
struct Meta {
    partitions: Vec<String>,
}

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
struct Songs {
    meta: Meta,
    songs: HashMap<String, Song>,
}

static SONGS: std::sync::OnceLock<Songs> = std::sync::OnceLock::new();

#[get("/songs.json")]
async fn get_songs() -> Result<Value, String> {
    let songs = SONGS
        .get()
        .ok_or_else(|| "Songs hasn't been initialized".to_owned())?;

    return json::to_value(songs).or_else(|error| {
        error!("Failed to serialize songs: {}", error);
        Err("Failed to serialize songs".to_owned())
    });
}

async fn load_songs(rocket: Rocket<Build>) -> fairing::Result {
    let mut entries = match tokio::fs::read_dir(relative!("jsongs/")).await {
        Ok(filenames) => filenames,
        Err(error) => {
            error!("Failed to list files in 'jsongs/': {}", error);
            return Err(rocket);
        }
    };

    let mut songs = HashMap::<String, Song>::new();
    while let Some(entry) = match entries.next_entry().await {
        Ok(entry) => entry,
        Err(error) => {
            error!("Failed to get next directory entry: {}", error);
            return Err(rocket);
        }
    } {
        if entry.file_name().to_string_lossy() == "__META__.json"
            || entry
                .metadata()
                .await
                .expect("reading metadata to work")
                .is_dir()
        {
            continue;
        }

        let json = match tokio::fs::read_to_string(entry.path()).await {
            Ok(json) => json,
            Err(error) => {
                error!(
                    "Failed to read '{}': {}",
                    entry.path().to_string_lossy(),
                    error
                );
                return Err(rocket);
            }
        };

        let id = entry
            .path()
            .file_stem()
            .expect("file path isn't expty")
            .to_string_lossy()
            .into_owned();
        let song: Song = match json::from_str(&json) {
            Ok(m) => m,
            Err(error) => {
                error!(
                    "Failed to parse the '{}' content: {}",
                    entry.path().to_string_lossy(),
                    error
                );
                return Err(rocket);
            }
        };
        songs.insert(id, song);
    }

    let meta_json = match tokio::fs::read_to_string(relative!("jsongs/__META__.json")).await {
        Ok(string) => string,
        Err(error) => {
            error!("Failed to read 'jsongs/__META__.json': {}", error);
            return Err(rocket);
        }
    };

    let meta: Meta = match json::from_str(&meta_json) {
        Ok(meta) => meta,
        Err(error) => {
            error!("Failed to parse 'jsongs/__META__.json': {}", error);
            return Err(rocket);
        }
    };

    if SONGS.set(Songs { meta, songs }).is_err() {
        error!("Songs map already initialized");
        return Err(rocket);
    }

    Ok(rocket)
}

#[launch]
fn rocket() -> _ {
    let figment = rocket::Config::figment();

    rocket::custom(figment)
        .attach(AdHoc::try_on_ignite("Song loading", load_songs))
        .mount("/", routes![get_songs])
        .mount("/", FileServer::from(relative!("build")).rank(20))
}
