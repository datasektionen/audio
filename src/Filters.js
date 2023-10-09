import React, { useState, useEffect } from 'react'

const defaultChapterName = "Övriga Sånger"

// The component below the SearchBar, handling search filters
export const Filters = ({partitions, chosenPartition, setChosenPartition, tags, chosenTags, setChosenTags}) => {

    let clearFilters = () => {
        setChosenPartition(-1)
        setChosenTags([])
    }

    //Count number of applied filters
    let numFilters = 0
    numFilters += chosenPartition != -1
    numFilters += chosenTags.length

    const [ hidden, setHidden ] = useState(true)
    const [ showPartitions, setShowPartitions ] = useState(false)
    const [ showTags, setShowTags ] = useState(false)


    let partitionName = getPartitionName(chosenPartition, partitions)


    if(hidden && showPartitions){
        setShowPartitions(false);
    }
    if(hidden && showTags){
        setShowTags(false);
    }

    return (
        <div>
            <div className='flex flex-row '>
              <button className='text-white flex-grow font-thin hover:bg-[#222222]  rounded-3xl' onClick={() => setHidden(!hidden)}>
                {hidden?"Visa Filter":"Dölj Filter"}
              </button>
              <button className={`${numFilters==0?"hidden":""} text-white flex-grow font-thin hover:bg-[#222222]  rounded-3xl`} onClick={() => clearFilters()}>
            {`Rensa Filter (${numFilters})`}
              </button>
            </div>
        <div className={`${hidden?"py-0" : "py-2"} duration-250 my-2 p-4 bg-transparent text-white`}>
            <div class={`${hidden?"max-h-0" : "max-h-[120pt]"} duration-250 overflow-hidden ${showPartitions||showTags?"overflow-visible" : ""} flex flex-col justify-center`}>
                
                <div class="relative text-left my-1">
                    <span>Partition:</span>
                    <button onClick={() => {setShowPartitions(!showPartitions); setShowTags(false);}} type="button" class="mx-4 inline-flex rounded-3xl bg-[#222222] px-3 py-1 hover:bg-[#444444]" id="menu-button" aria-expanded="true" aria-haspopup="true">
                        {partitionName}
                        <svg class="-mr-1 m-auto h-8 w-8 align-middle text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                        </svg>
                    </button>

                    <div hidden={!showPartitions} class="absolute left-0 z-10 ml-28 mt-2 py-2 rounded-md bg-[#222222] shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button">
                        <div class="mx-6 py-1 mr-2 flex flex-col max-h-[55vh] overflow-y-scroll scrollbar-thin scrollbar-thumb-zinc-500 scrollbar-track-zinc-900 scrollbar-thumb-rounded-full scrollbar-track-rounded-full">
                        {[-1, ...Array(partitions.length).keys(), -2].map(part =>
                            <button class="bg-transparent hover:bg-[#333333] px-5 mr-4"
                                        onClick={() => {
                                        setChosenPartition(part);
                                        setShowPartitions(false);
                                    }}>
                                    {getPartitionName(part, partitions)}
                                </button>
                            )}

                        </div>
                    </div>
                </div>
                
                <div class="relative text-left my-1">
                    <span>Taggar:</span>
                    <button disabled={chosenTags.length >= 3}  onClick={() => {setShowTags(!showTags); setShowPartitions(false);} } type="button" class="ml-4 mr-1 items-center inline-flex rounded-3xl bg-[#222222] px-3 py-[2px] hover:bg-[#444444] disabled:bg-[#111111] disabled:text-[#333333] disabled:hover:bg-[#111111]"  id="menu-button" aria-expanded="true" aria-haspopup="true">
                        Lägg Till<span className='py-0 my-0 mx-2 text-4xl text-gray-400'>&#43;</span>                        
                    </button>

                    <div hidden={!showTags} class="absolute left-0 z-10 ml-28 mt-2 py-2 rounded-md bg-[#222222] shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button">
                        <div class="mx-6 py-1 mr-2 flex flex-col max-h-[55vh] overflow-y-scroll scrollbar-thin scrollbar-thumb-zinc-500 scrollbar-track-zinc-900 scrollbar-thumb-rounded-full scrollbar-track-rounded-full">
                        {tags.filter(tag => !chosenTags.includes(tag)).map(tag =>
                            <button class="bg-transparent hover:bg-[#333333] px-5 mr-4"
                                        onClick={() => {
                                            setChosenTags([...chosenTags, tag]);
                                            setShowTags(false);
                                    }}>
                                    {tag}
                                </button>
                            )}

                        </div>
                    </div>
                    {chosenTags.map(tag => 
                            <span>
                                <button className='rounded-3xl bg-[#222222] px-3 m-1 py-[2px] hover:bg-[#444444]'
                                    onClick={() => setChosenTags(chosenTags.filter((chosen) => chosen != tag))}>
                                    {tag}
                                    <span className='py-0 my-0 mx-2 text-2xl text-gray-400'>&#10006;</span>
                                </button>
                            </span>
                        )}
                </div>
                
            </div>
        </div>
    </div>
    )
}

function getPartitionName(i, partitions){
    if(i >= 0){
        return partitions[i]
    } else if(i == -2){
        return "Övriga Sånger"
    } else {
        return "Alla"
    }
}