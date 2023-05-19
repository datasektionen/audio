import React, { useState, useEffect } from 'react'
import {ReactComponent as Cover} from './assets/Omslag.svg';

const BINARY_MESSAGE = "DATASEKTIONENS SÅNGBOK"

// takes binary int and returns hex string
function dec2bin(dec) {
    return (dec >>> 0).toString(2);
  }

// The white page containing a song.
export const SongPage = ({ song, bookletIndex, partitions, removeSong }) => {

    let i = (bookletIndex*2)%BINARY_MESSAGE.length
    let i2 = (bookletIndex*2 + 1)%BINARY_MESSAGE.length
    let binary_string = dec2bin(BINARY_MESSAGE.charCodeAt(i)) + " " + dec2bin(BINARY_MESSAGE.charCodeAt(i2))


    let chapter = "Partition Null - Övriga Sånger"
    if("partition" in song){
      chapter = `Partition ${song.partition + 1} - ${partitions[song.partition]}`
    }

    let page = ""
    if("5ePage" in song){
        page = song["5ePage"]
        if(page % 2 == 1){
            //Make into hex if odd
            page = "0x" + page.toString(16).toUpperCase()
        }
    }

    return (
        <>
            <div className={'landscape:h-[calc(90vh-7rem)] portrait:w-[calc(90vw)] text-black bg-white min-h-0 aspect-[1/1.414] max-w-[90vw] max-h-[calc(90vh-7rem)] flex flex-col px-10 py-5 whitespace-pre-wrap font-serif leading-tight break-normal scroll overflow-y-auto scrollbar-thin scrollbar-thumb-zinc-700 scrollbar-track-zinc-200 scrollbar-thumb-rounded-full scrollbar-track-rounded-full overflow-hidden'}>

                <div className='text-right'>{chapter}</div>
                <div className='text-right text-sm'>{binary_string}</div>
                <h2 className={'text-4xl'}>
                <b>{song.title}</b>
                </h2>
                <i>{song.meta}</i>
                <p className='pt-2' dangerouslySetInnerHTML={{__html: song.text}} />
                <i><p className='pt-4 text-gray-900 whitespace-pre-wrap' dangerouslySetInnerHTML={{__html: song.notes}} /></i>
                <div className='flex-grow'></div>
                <div className='text-right'>{page}</div>

            </div>
            <div className='absolute'>
            <button onClick={() => {removeSong(bookletIndex)}} className="absolute top-[-20px] left-[-20px] pb-1 font-lg w-16 h-16 bg-zinc-600 m-auto rounded-full hover:bg-zinc-500 disabled:hover:bg-zinc-800 disabled:bg-zinc-800 disabled:text-gray-500">
                x
            </button>
        </div>
    </>
    )
}

export default SongPage
