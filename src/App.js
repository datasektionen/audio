import React, { Fragment, useEffect, useState } from 'react'
import styled from 'styled-components'
import fuzzysort from 'fuzzysort'

import Methone from 'methone'

import preval from 'preval.macro'

const allSongs = preval`module.exports = require('./getSongs.js')`

const config = {
  system_name: "audio",
  color_scheme: "deep-orange",
  login_text: "",
  login_href: "",
  links: [
    {
      str: "Portos Visa",
      href: "#portos_visa"
    },
    {
      str: "Hej på er bröder alla",
      href: "#hej_pa_er_broder_alla"
    },
    {
      str: "Skitåkare Andersson",
      href: "#skitakare_andersson"
    },
  ]
}

const Song = styled.div`
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

const Search = styled.input`
  width: 100%;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.1);
`

const List = styled.div``

const ListItem = styled.a`
  display: block;
  margin: 5px 0;
  padding: 10px;
  border: 1px solid #EEE;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);

  :hover {
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
    background: #EEE
  }
`

function useHash() {
  const [ hash, setHash ] = useState(window.location.hash.substr(1))
  useEffect(() => {
    const fn = () => setHash(window.location.hash.substr(1))
    window.addEventListener('hashchange', fn)
    return () => {
      window.removeEventListener('hashchange', fn)
    }
  }, [])
  return hash
}

function App() {
  const hash = useHash()
  const song = hash && allSongs[hash]

  const [ songs, setSongs ] = useState(Object.values(allSongs))

  const handleSearchChange = e => {
    if(e.target.value) {
      fuzzysort.goAsync(e.target.value, Object.values(allSongs), {keys: ['title', 'alttitle', 'id'], allowTypo: true})
        .then(s => setSongs(s.map(s => ({
            ...s.obj,
            title: fuzzysort.highlight(s[0]) || s.obj.title,
            alttitle: fuzzysort.highlight(s[1]) || s.obj.alttitle,
          }
        ))))
    } else {
      setSongs(Object.values(allSongs))
    }
  }

  return (
    <Fragment>
      <Methone config={config} />
      <div id="application" className="deep-orange">
        <header>
          <div className="header-inner">
            <div className="row">
              <div className="header-left col-md-2"></div>
              <div className="col-md-8"><h2>/dev/audio</h2></div>
              <div className="header-right col-md-2"></div>
            </div>
          </div>
        </header>
        <div id="content">
          {song &&
            <Song id={song.id}>
              <h2>
                {song.title} {song.alttitle && `(${song.alttitle})`}
              </h2>
              <p className='meta'>
                {song.meta}
              </p>
              <p id='text' dangerouslySetInnerHTML={{__html: song.text}} />
              <p className='notes' dangerouslySetInnerHTML={{__html: song.notes}} />
            </Song>
          }
          <Search
            placeholder='Bordauxe bordaux'
            onChange={handleSearchChange}
          />
          <List>
            {songs.map(song =>
              <ListItem
                key={song.id}
                href={'#' + song.id}
                onClick={() => window.scroll(0, 0)}
              >
                <span dangerouslySetInnerHTML={{__html:
                  `${song.title}${song.alttitle ? ` (${song.alttitle})` : ''}`}}
                />
              </ListItem>)}
          </List>
        </div>
      </div>
    </Fragment>
  )
}


export default App;
