import React, { useState, useEffect } from 'react'
import {ReactComponent as Cover} from './assets/Omslag.svg';

const BINARY_MESSAGE = "DATASEKTIONENS SÅNGBOK"

function dec2bin(dec) {
    return (dec >>> 0).toString(2);
  }

export const SongPage = ({ song, bookletIndex }) => {

    let i = (bookletIndex*2)%BINARY_MESSAGE.length
    let i2 = (bookletIndex*2 + 1)%BINARY_MESSAGE.length
    let binary_string = dec2bin(BINARY_MESSAGE.charCodeAt(i)) + " " + dec2bin(BINARY_MESSAGE.charCodeAt(i2))

    let chapter = "Partition 15 - Övriga Sånger"
    if("chapter" in song){
        chapter = song.chapter
    }

    let page = ""
    if("page" in song){
        page = song.page
        if(page % 2 == 1){
            //Make into hex if odd
            page = "0x" + page.toString(16).toUpperCase()
        }
    }

    return ( 
        <div className={'landscape:h-[calc(90vh-7rem)] portrait:w-[calc(90vw)] text-black bg-white min-h-0 aspect-[1/1.414] max-w-[90vw] max-h-[calc(90vh-7rem)] flex flex-col px-10 py-5 whitespace-pre-wrap font-serif leading-tight break-normal overflow-hidden scroll overflow-y-auto scrollbar-thin scrollbar-thumb-zinc-700 scrollbar-track-zinc-200 scrollbar-thumb-rounded-full scrollbar-track-rounded-full'}>
            
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
    )
}

export default SongPage
