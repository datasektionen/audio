import React, { useState } from 'react'
import styled from 'styled-components'
import fuzzysort from 'fuzzysort'


const Search = styled.input`
  width: 100%;
  padding: 10px;
  margin: 10px 0;
  border: 1px solid #EEE;
  box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.1);
  font-size: 1.1em;
`

const List = styled.div`
  margin: 10px 0;
`

const ListItem = styled.div`
  display: flex;
  margin: 5px 0;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
  transition: none;
  align-items: center;

  font-size: 1.1em;

  :hover {
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    background: #EEE;
    cursor: pointer;
  }

  span {
    flex: 1;
  }

  button {
    margin-left: 5px;
    padding: 0;
    width: 2em;
    height: 2em;
    background: none;
    box-shadow: none;
    color: #ff5722;

    :hover {
      font-weight: bold;
    }

    @media only screen and (max-width: 600px) {
      margin-left: 0;
    }
  }
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
        <ListItem key={song.id} onClick={e => playNow(song.id, e)} >
          <span dangerouslySetInnerHTML={{__html: `${song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}} />
          <button
            title="Add after the currently expanded song. First if no song is expanded."
            onClick={e => playNext(song.id, e)}
          >
            ›
          </button>
          <button
            title="Add to the end of the queue."
            onClick={e => addToQueue(song.id, e)}
          >
            ››
          </button>
        </ListItem>)}
    </List>
  </>
}

export default Songs
