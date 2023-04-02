import { Input } from 'postcss';
import {ReactComponent as Logo} from './assets/Logga.svg';
import SearchBar from './SearchBar';
import preval from 'preval.macro'
import React, { useState } from 'react'
import SongBook from './SongBook';

const songs = preval`module.exports = require('./getSongs.js')`
var seedrandom = require('seedrandom');

var songOfTheDay

// Gets a random song, seeded from todays date, so that everyone has the same random song, everyday.
function setSongOfTheDay(){
    var date = new Date() // Todays date
    var dayID = date.getDate() + date.getMonth()*10 + date.getFullYear()*1000
    
    var rng = seedrandom(dayID);
    var rand = Math.floor(rng()*(Object.keys(songs).length-1))
    songOfTheDay = Object.values(songs)[rand]
}

setSongOfTheDay()

export const App = () => {

    console.log(songs)

    const [ hideNav, setHideNav ] = useState(true)
    const [ bookletList, setbookletList ] = useState([])
    const [ songIndex, setSongIndex ] = useState(bookletList.length - 1)

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
    
    // Gets a random song and adds it to the booklet
    const addRandomSong = () => {
        var rand = Math.floor(Math.random()*(Object.keys(songs).length-1))
        var randomSong = Object.values(songs)[rand]
        addToBooklet(randomSong.id)
    }

    //Adds trippeln to the 
    const addTrippeln = () => {
        addToBooklet(["portos_visa", "skitakare_andersson", "hej_pa_er_broder_alla"])
        // Set the current song index to "Portos visa".
        setSongIndex(bookletList.length)
    }

    return (
        <div className="max-h-screen max-w-screen w-screen h-screen flex flex-col bg-zinc-900 overflow-hidden">
            {/* Header */}
            <div className={`${!hideNav?"bg-black lg:bg-inherit":""} z-20 relative flex flex-none flex-col lg:flex-row lg:bg-inherit`}>
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
            <div className="flex-1 flex flex-row h-0"> {/*"calc(100vh-9rem)" calculates viewport height minues header height.*/}
                <div className="flex-grow"/>
                <div className="flex-grow w-[700pt] m-auto">
                    <SongBook bookletList={bookletList} allSongs={songs} songIndex={songIndex} setSongIndex={setSongIndex} />
                </div>
                {/* Sidebar */}
                <div className="flex-grow"/>
                <SearchBar allSongs={Object.values(songs)} addToBooklet={addToBooklet} bookletList={bookletList}/>
            </div>

        </div>
    );
}
export default App;
