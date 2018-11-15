import React, { Fragment, useEffect, useState } from 'react'
import Methone from 'methone'

import preval from 'preval.macro'

const songs = preval`module.exports = require('./getSongs.js')`

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

function useHash() {
  const [ hash, setHash ] = useState(window.location.hash.substr(1))
  useEffect(() => {
    window.addEventListener('hashchange', () => setHash(window.location.hash.substr(1)))
  }, [])
  return hash
}

function App() {
  const hash = useHash()
  const song = hash && songs[hash]

  const [ filter, setFilter ] = useState('')

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
            <div>
              <h2>
                {song.title} {song.alttitle && `(${song.alttitle})`}
              </h2>
              <p style={{whiteSpace: 'pre-wrap'}}>
              {song.meta}
              </p>
              <p style={{
                  whiteSpace: 'pre-wrap',
                  color: 'black'
                }}
                dangerouslySetInnerHTML={{__html: song.text}} />
              <p dangerouslySetInnerHTML={{__html: song.notes}} />
            </div>
          }
          <input onChange={e => setFilter(e.target.value)} />
          <ul>
            {Object.values(songs)
              .filter(song =>
                song.id.includes(filter) ||
                song.title.includes(filter) ||
                (song.alttitle && song.alttitle.includes(filter)))
              .map(song =>
              <li name={song.id} key={song.id}>
                <a href={'#' + song.id}>
                  {song.title} {song.alttitle && `(${song.alttitle})`}
                </a>
              </li>)}
          </ul>
        </div>
      </div>
    </Fragment>
  )
}

export default App;
