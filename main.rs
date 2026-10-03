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
use std::fs;

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
}

static SONGS: std::sync::OnceLock<HashMap<String, Song>> = std::sync::OnceLock::new();

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
    let Ok(Ok(json)) =
        tokio::task::spawn_blocking(|| fs::read_to_string(relative!("songs.json"))).await
    else {
        error!("Failed to read the songs.json file");
        return Err(rocket);
    };

    let map: HashMap<String, Song> = match json::from_str(&json) {
        Ok(m) => m,
        Err(e) => {
            error!("Failed to parse the songs.json content: {}", e);
            return Err(rocket);
        }
    };

    if SONGS.set(map).is_err() {
        error!("Songs map already initialized");
        return Err(rocket);
    }

    Ok(rocket)
}

#[launch]
fn rocket() -> _ {
    let figment = rocket::Config::figment();

    rocket::custom(figment)
        .attach(AdHoc::try_on_ignite("Song reading", load_songs))
        .mount("/", routes![get_songs])
        .mount("/", FileServer::from(relative!("build")).rank(20))
}
