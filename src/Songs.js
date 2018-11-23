import React, { useState } from 'react'
import styled from 'styled-components'
import fuzzysort from 'fuzzysort'


const Search = styled.input`
  width: 100%;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.1);
`

const List = styled.div`
`

const ListItem = styled.div`
  display: block;
  margin: 5px 0;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
  transition: none;

  :hover {
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    background: #EEE;
    cursor: pointer;
  }
`

const Button = styled.button`
  float: right;
`

export const Songs = ({ songList, addToPlaylist, setExpanded }) => {

  const [ songs, setSongs ] = useState(songList)

  const handleSearchChange = e => {
    if(e.target.value) {
      fuzzysort.goAsync(e.target.value, songList, {keys: ['title', 'alttitle', 'firstline', 'id'], allowTypo: true})
        .then(s => setSongs(s.map(s => ({
            ...s.obj,
            title: fuzzysort.highlight(s[0]) || s.obj.title,
            alttitle: fuzzysort.highlight(s[1]) || s.obj.alttitle,
          }
        ))))
    } else {
      setSongs(songList)
    }
  }

  const playNow = (songId, e) => {
    window.scroll(0, 100)
    addToPlaylist(songId, true)
    setExpanded(songId)
  }

  const playNext = (songId, e) => {
    e.stopPropagation()
    addToPlaylist(songId, true)
  }

  const addToQueue = (songId, e) => {
    e.stopPropagation()
    addToPlaylist(songId)
  }

  return <>
    <Search
      placeholder='Bordauxe bordaux'
      onChange={handleSearchChange}
    />
    <List>
      {songs.map(song =>
        <ListItem
          key={song.id}
          href={'/' + song.id}
          onClick={e => playNow(song.id, e)}
        >
          <span dangerouslySetInnerHTML={{__html: `${song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}} />

          <Button onClick={e => playNext(song.id, e)}>
            Add next
          </Button>
          <Button onClick={e => addToQueue(song.id, e)}>
            Add last
          </Button>
        </ListItem>)}
    </List>
  </>
}

export default Songs
