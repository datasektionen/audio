import { Input } from 'postcss';
import {ReactComponent as Logo} from './assets/Logga.svg';
import {ReactComponent as Cover} from './assets/Omslag.svg';
import SearchBar from './SearchBar';
import preval from 'preval.macro'
import React, { useState, useEffect } from 'react'
import SongBook from './SongBook';

const originUrl = window.location.hostname;
var seedrandom = require('seedrandom');

var globalSongs;
var songOfTheDay;
var metaData;

//When testing, set this variable to true, in order to load songs statically, rather than from the database
var loadSongsStatically = false;
// uncomment below line if loading songs statically
//const staticSongs = preval`module.exports = require('./getSongs.js')`;
var partitions = ["Gasquesånger", "Datasånger", "Sektionssånger", "Sånger till Ölet", "Sånger till Vinet", "Punschvisor", "Nubbevisor", "Dagen efter", "Traditionellt", "Högtid", "Säsånger", "Roliga Sånger", "Mottagningssånger"];


// Gets a random song, seeded from todays date, so that everyone has the same random song, everyday.
function setSongOfTheDay(attempt = 0){
    var date = new Date(); // Todays date
    var dayID = date.getDate() + date.getMonth()*10 + date.getFullYear()*1000;

    var rng = seedrandom(dayID);
    while(true){
      var rand = Math.floor(rng()*(Object.keys(globalSongs).length-1));
      songOfTheDay = Object.values(globalSongs)[rand];
      console.log(songOfTheDay);
      if(!"preventSongOfTheDay" in songOfTheDay || !songOfTheDay["preventSongOfTheDay"]){
        break;
      }
    }

}

export const App = () => {
    //Hide navigation bar, relevant only when in mobile
    const [ hideNav, setHideNav ] = useState(true)
    // Loading songs from API
    const [ isLoading, setIsLoading ] = useState(true)
    // List of songs, currently in the "booklet", i.e. songlist
    const [ bookletList, setbookletList ] = useState([])
    // The current index in the booklet
    const [ songIndex, setSongIndex ] = useState(bookletList.length - 1)
    // All songs
    const [ songs, setSongs ] = useState({});

    // Fetch ALL songs as a single API request to the backend.
    useEffect(() => {
        const getSongs = async () => {
          if(loadSongsStatically){
            globalSongs = staticSongs;
          } else {
            let url = "http://" + window.location.host + "/songs.json";
            var res = await fetch(url);
            var json = await res.json();
              globalSongs = json;
          }
          console.log("__META__" in globalSongs)
          console.log(globalSongs)
          console.log("__META__" in globalSongs && "partitions" in globalSongs["__META__"])
          if("__META__" in globalSongs){
            metaData = globalSongs["__META__"]
            delete globalSongs["__META__"]
            if("partitions" in metaData){
              partitions = metaData["partitions"]
            }
          }

          setSongOfTheDay();
          setSongs(globalSongs);
          setIsLoading(false);
        };
        getSongs();
    }, [])

    //Adds songs with specified IDs to the booklet.
    const addToBooklet = (songIds) => {

        // If parameter is string, convert to array
        if ((typeof songIds) === "string"){
            songIds = [songIds]
        }
        // If song already in list, remove it and add it again to the end.
        songIds.forEach(songId => {
            if(bookletList.includes(songId)){
                const index = bookletList.indexOf(songId);
                if (index > -1) { // only splice array when item is found
                    bookletList.splice(index, 1); // 2nd parameter means remove one item only
                }
            }
        })
        setbookletList([...bookletList, ...songIds])
        // Set the current song index to the last song (just added)
        setSongIndex(bookletList.length + songIds.length - 1)
    }

    const removeFromBooklet = (index) => {
        bookletList.splice(index, 1)
        setbookletList([...bookletList]);
        if (songIndex >= bookletList.length){
            setSongIndex(songIndex - 1)
        }
    }

    // Gets a random song and adds it to the booklet
    const addRandomSong = () => {
        var rand = Math.floor(Math.random()*(Object.keys(songs).length-1))
        var randomSong = Object.values(songs)[rand]
        addToBooklet(randomSong.id)
    }

    //Adds trippeln to the booklet
    const addTrippeln = () => {
        addToBooklet(["portos_visa", "skitakare_andersson", "hej_pa_er_broder_alla"])
        // Set the current song index to "Portos visa".
        setSongIndex(bookletList.length)
    }

    let mainBody
    if(!isLoading){
        mainBody = <>
        {/* Header */}
        <div className={`${!hideNav?"bg-black lg:bg-inherit":""} z-11 relative flex flex-none flex-col lg:flex-row lg:bg-inherit`}>
          <div className='flex-1'/>
          <div className='flex flex-row'>
            <div className='flex-1'/>
            <Logo fill="#EE2A7B" className="flex-initial h-28 py-4"/>
            <div className='flex-1'>
              <button onClick={() => setHideNav(!hideNav)} className="lg:hidden flex w-28 h-full items-center border rounded text-[#EC5F99] hover:bg-zinc-800 ml-auto">
              <div className='rotate-90 m-auto'>|||</div>
              </button>
              <div className='flex-1'/>
            </div>
          </div>
          <div className='relative flex-1 justify-end h-28'>
            <nav hidden={false} className={`${hideNav?"h-0 p-0 lg:h-fit lg:p-2 bg-inherit":"h-64 p-2 bg-black"} flex flex-col overflow-hidden z-20 absolute lg:items-center lg:bg-inherit lg:static inset-x-0 top-0 lg:flex-row lg:justify-end lg:h-28 text-[#EC5F99] text-2xl px-6 lg:pr-10`}>
            <button onClick={() => {addTrippeln(); setHideNav(true)}} className='h-full p-2 hover:bg-zinc-800 rounded-2xl'>
            <div className='m-2'>
              Trippeln
            </div>
            </button>
            <button onClick={() => {addRandomSong(); setHideNav(true)}} className='h-full p-2 hover:bg-zinc-800 rounded-2xl'>
            <div className='m-2'>
              Slumpmässig Sång
            </div>
            </button>
            <button onClick={() => {addToBooklet(songOfTheDay.id); setHideNav(true)}} className='h-full p-2 hover:bg-zinc-800 rounded-2xl'>
            <div className='m-2'>
              Dagens Sång:
            </div>
            <div className='max-w-full lg:max-w-[128pt] m-auto truncate overflow-clip'>
              {songOfTheDay.title}
            </div>
            </button>
          </nav>
        </div>
      </div>
      {/* Body */}
      <div className="flex-1 flex flex-row h-0">
        <div className="flex-grow"/>
        <div className="flex-grow w-[700pt] m-auto">
          <SongBook bookletList={bookletList} allSongs={songs} songIndex={songIndex} setSongIndex={setSongIndex} partitions={partitions} removeFromBooklet={removeFromBooklet}/>
        </div>
        {/* Sidebar */}
        <div className="flex-grow"/>
        <SearchBar allSongs={Object.values(songs)} addToBooklet={addToBooklet} bookletList={bookletList} partitions={partitions}/>
      </div>
      <div className="absolute bottom-0">
          {/*Utvecklad av: Max Wippich, Sångledare 2023, i samarbete med IOR*/}
      </div>
      </>
    }

    return (
      <div className={`max-h-screen max-w-screen w-screen h-screen bg-zinc-900`}>

      <div className={`fixed z-10 pointer-events-none h-screen max-w-screen w-screen bg-zinc-900 flex flex-col justify-center items-center transition-opacity ease-in-out duration-1000 ${!isLoading?"opacity-0":""}`}>
        <Cover fill="#EE2A7B" className="animate-pulse max-h-[60vh] max-w-[90vw]"/>
        <p className="animate-pulse text-7xl text-[#EE2A7B] font-serif">
          Loading...
        </p>
      </div>
        <div className={`max-h-screen h-screen flex flex-col overflow-hidden transition-opacity ease-in duration-700 opacity-100`}>
        {mainBody}
      </div>
    </div>
        );
}
export default App;
