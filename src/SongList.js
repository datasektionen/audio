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

const ListItem = styled.a`
  display: block;
  margin: 5px 0;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
  transition: none;

  :hover {
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    background: #EEE;
  }
`

const Button = styled.button`
  margin-left: auto;
`

export const SongList = ({ setSong, songList, addToPlaylist }) => {

  const [ songs, setSongs ] = useState(songList)

  const handleSearchChange = e => {
    if(e.target.value) {
      fuzzysort.goAsync(e.target.value, songList, {keys: ['title', 'alttitle', 'id'], allowTypo: true})
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

  const addSong = (songId, e) => {
    e.stopPropagation()
    e.preventDefault()
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
          onClick={e => {
            e.preventDefault()
            setSong(song.id)
            window.scroll(0, 0)
          }}
        >
          <span dangerouslySetInnerHTML={{__html:
            `${song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}}
          />
          <Button onClick={e => addSong(song.id, e)}>
            +
          </Button>
        </ListItem>)}
    </List>
  </>
}

export default SongList
