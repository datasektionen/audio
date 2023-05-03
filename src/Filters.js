import React, { useState, useEffect } from 'react'

const defaultChapterName = "Övriga Sånger"

export const Filters = ({hidden, partitions, chosenPartition, setChosenPartition}) => {

    const [ showPartitions, setShowPartitions ] = useState(false)

    console.log(chosenPartition)
    
    let partitionName = getPartitionName(chosenPartition, partitions)
    

    if(hidden && showPartitions){
        setShowPartitions(false);
    }

    return (
        <div className={`${hidden?"py-0" : "py-2"} my-2 p-4 bg-transparent text-white`}>
            <div class={`${hidden?"h-0" : "h-[30pt]"} overflow-hidden ${showPartitions?"overflow-visible" : ""} flex flex-col justify-center`}>
                <div>
                    <div class="relative inline-block text-left">
                    <span>Partition:</span>
                    <button onClick={() => setShowPartitions(!showPartitions)} type="button" class="mx-4 inline-flex rounded-3xl bg-[#222222] px-3 py-2 hover:bg-[#444444]" id="menu-button" aria-expanded="true" aria-haspopup="true">
                        {partitionName}
                        <svg class="-mr-1 m-auto h-8 w-8 align-middle text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z" clip-rule="evenodd" />
                        </svg>
                    </button>
                        
                        <div hidden={!showPartitions} class="absolute left-0 z-10 ml-28 mt-2 py-2 rounded-md bg-[#222222] shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
                            <div class="mx-6 py-1 mr-2 flex flex-col max-h-[50vh] overflow-y-scroll scrollbar-thin scrollbar-thumb-zinc-500 scrollbar-track-zinc-900 scrollbar-thumb-rounded-full scrollbar-track-rounded-full">
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