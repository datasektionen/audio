import React from 'react'
import styled from 'styled-components'
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd'

const List = styled.div`
`

const ListItem = styled.div`
  transition: none;
  border: 1px solid black;
  #text {
    white-space: pre-wrap;
    color: black;
  }

  .meta {
    white-space: pre-wrap;
  }

  .notes {
    ol {
      margin-left: 40px;
    }
  }
`

const Button = styled.button`
  float: right;
`

export const Playlist = ({ songs, expanded, setExpanded, playlist, setPlaylist }) => {
  const removeSong = (song, e) => {
    e.stopPropagation()
    e.preventDefault()
    setPlaylist(playlist.filter(s => s !== song.id))
  }

  const onDragEnd = result => {
    // dropped outside the list
    if (!result.destination) {
      return
    }

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
                    <div>
                      <h2 {...dragHandleProps}>
                        <Button onClick={e => removeSong(song, e)}>
                          remove
                        </Button>
                        <Button onClick={() => song.id === expanded ? setExpanded(false) : setExpanded(song.id)} >
                          {song.id === expanded ? 'contract' : 'expand'}
                        </Button>

                        {song.title} {song.alttitle && `(${song.alttitle})`}
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
                    </div>
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
