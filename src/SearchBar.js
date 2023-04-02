import React, { useState, useEffect } from 'react'
import fuzzysort from 'fuzzysort'



export const SearchBar = ({ allSongs, addToBooklet, bookletList}) => {

  const [ songs, setSongs ] = useState(allSongs)
  const [ show, setShow ] = useState(true)

  //If song changes, 
  useEffect(() => {
    if(show && window.innerWidth < 768){
      handleCollapse()
    }
  }, [bookletList])
  
  const handleCollapse = e => {
    setShow(!show)
  }

  const handleSearchChange = e => {
    if(e.target.value) {
        fuzzysort.goAsync(e.target.value, allSongs, {keys: ['title', 'alttitle', 'firstline', 'id'], allowTypo: true})
          .then(s => setSongs(s.map(s => ({
              ...s.obj,
              title: fuzzysort.highlight(s[0]) || s.obj.title,
              alttitle: fuzzysort.highlight(s[1]) || s.obj.alttitle,
            }
          ))))
      } else {
        setSongs(allSongs)
      }
  }
  return (
    <div className={`${show? "w-[350pt]":"w-0"} min-w-0 max-w-full pt-28 md:pt-0 py-10 absolute inset-y-0 right-0 z-10 md:static h-full flex flex-row justify-end`}>
        <button className='my-auto min-w-[3rem] md:min-w-[2.5rem] h-24 p-3 rounded-l-2xl bg-zinc-800 text-white hover:bg-zinc-700' onClick={handleCollapse}>
            {show?">":"<"}
        </button>
        <div className={`${!show? "w-0 px-0":"w-full"} bg-[#0B0B0B] flex flex-col rounded-l-3xl p-5 h-full w-full overflow-hidden`}>
              
            <input className='rounded-full p-3 pl-6 bg-gray-200 placeholder-gray-400 mb-4 min-w-0' 
                placeholder = "Kalmarevisan"
                onChange={handleSearchChange}
            />
            <div className='scroll overflow-y-auto scrollbar-thin scrollbar-thumb-zinc-500 scrollbar-track-zinc-900 scrollbar-thumb-rounded-full scrollbar-track-rounded-full '>
                
                {songs.map(song =>
                    <SongTile key={song.id} song ={song} addToBooklet={addToBooklet} handleCollapse={handleCollapse}/>
                )}
            </div>
        </div>
    </div>
  )
}

const SongTile = ({ song, addToBooklet, divider = true, prefix = ""}) => {
  return (
    <div>
      <div onClick={e => {addToBooklet(song.id, e)}} className="text-white overflow-hiddenw m-0.5 px-4 py-1 rounded-3xl hover:bg-[#222222] cursor-pointer">
          <div dangerouslySetInnerHTML={{__html: `${prefix+song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}} />
      </div>
      
      <hr hidden={!divider} className='border-[#333333] m-1 mx-3'/>
    </div>
  )
}

export default SearchBar
