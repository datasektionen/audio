import React from 'react'
import styled from 'styled-components'

const Song = styled(({ song, setSong, ...props }) =>
  <>
    {song &&
      <div {...props} >
        <button onClick={e => setSong('_')}>
          x
        </button>
        <h2>
          {song.title} {song.alttitle && `(${song.alttitle})`}
        </h2>
        <p className='meta'>
          {song.meta}
        </p>
        <p id='text' dangerouslySetInnerHTML={{__html: song.text}} />
        <p className='notes' dangerouslySetInnerHTML={{__html: song.notes}} />
      </div>
    }
  </>
  )`
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

export default Song
