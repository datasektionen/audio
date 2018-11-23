import React from 'react'
import styled from 'styled-components'
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd'

const List = styled.div`
`

const ListItem = styled.div`
  transition: none;
  background: #FFF;
  h2#h2 { /* need to do this because aurora */
    display: flex;
    align-items: center;
    margin: 0;
    padding: 10px 0;

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
    }
  }

  p {
    padding: 10px;
  }

  #text { /* aurora pls */
    white-space: pre-wrap;
    color: black;
  }

  .meta {
    white-space: pre-wrap;
  }

  .notes {
    ol { /* Specifically for the ahrskours-visah */
      margin-left: 40px;
    }
  }
`


export const Playlist = ({ songs, expanded, setExpanded, playlist, setPlaylist }) => {
  const removeSong = (song, e) => {
    e.stopPropagation()
    e.preventDefault()
    setPlaylist(playlist.filter(s => s !== song.id))
  }

  const onDragEnd = result => {
    if (!result.destination) return

    const source = result.source.index
    const destination = result.destination.index

    const removeSource = [
      ...playlist.slice(0, source),
      ...playlist.slice(source + 1)
    ]

    const replaceSource = [
      ...removeSource.slice(0, destination),
      playlist[source],
      ...removeSource.slice(destination)
    ]

    setPlaylist(replaceSource)
  }

  return <>
    <DragDropContext onDragEnd={onDragEnd}>
      <Droppable droppableId="droppable">
        {({ droppableProps, placeholder, innerRef }) =>
          <List ref={innerRef} {...droppableProps}>
            {playlist.map(songId => songs[songId]).map((song, index) =>
              <Draggable key={song.id} draggableId={song.id} index={index}>
                {({ draggableProps, dragHandleProps, innerRef }) =>
                  <ListItem ref={innerRef} {...draggableProps} >
                    <>
                      <h2 id="h2" {...dragHandleProps} onClick={() => song.id === expanded ? setExpanded(false) : setExpanded(song.id)}>
                        <span>
                          {song.title} {song.alttitle && `(${song.alttitle})`}
                        </span>
                        <button onClick={() => song.id === expanded ? setExpanded(false) : setExpanded(song.id)} >
                          {song.id === expanded ? ' ⌃' : '⌄'}
                        </button>
                        <button className="remove" onClick={e => removeSong(song, e)}>
                          x
                        </button>
                      </h2>
                      {
                        song.id === expanded &&
                        <>
                          <p className='meta'>
                            {song.meta}
                          </p>
                          <p id='text' dangerouslySetInnerHTML={{__html: song.text}} />
                          <p className='notes' dangerouslySetInnerHTML={{__html: song.notes}} />
                        </>
                      }
                    </>
                  </ListItem>
                }
              </Draggable>)}
            {placeholder}
          </List>
        }
      </Droppable>
    </DragDropContext>
  </>
}

export default Playlist
