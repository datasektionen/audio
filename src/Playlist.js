import React from 'react'
import styled from 'styled-components'
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';

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

export const Playlist = ({ songs, setSong, playlist, setPlaylist }) => {
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
                  <ListItem
                    href={'/' + song.id}
                    ref={innerRef}
                    {...draggableProps}
                    {...dragHandleProps}
                    onClick={e => {
                      e.preventDefault()
                      setSong(song.id)
                    }}
                  >
                    <span dangerouslySetInnerHTML={{__html:
                      `${song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}}
                    />
                    <Button onClick={e => removeSong(song, e)}>
                      -
                    </Button>
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
