import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'

import Methone from 'methone'

import registerServiceWorker from './registerServiceWorker'

import Playlist from './Playlist'
import Songs from './Songs'

import './index.css'

import preval from 'preval.macro'
const songs = preval`module.exports = require('./getSongs.js')`

const config = {
  system_name: "audio",
  color_scheme: "deep-orange",
  login_text: "",
  login_href: "",
  links: [
    {
      str: "Trippeln",
      href: "/portos_visa,hej_pa_er_broder_alla,skitakare_andersson#portos_visa"
    },
    {
      str: "Årskursvisan",
      href: "/arskursvisan#arskursvisan"
    },
  ]
}

const useHistory = () => {
  const [ route, setRoute ] = useState(window.location.pathname)

  useEffect(() => {
    const listener = () => setRoute(window.location.pathname)

    window.addEventListener('popstate', listener)
    return () => {
      window.removeEventListener('popstate', listener)
    }
  }, [])

  return {
    route,
    push: route => {
      setRoute(route)
      window.history.pushState({ route }, document.title, route)
    },
    replace: route => {
      setRoute(route)
      window.history.replaceState({ route }, document.title, route)
    },
    go: window.history.go,
    back: window.history.back,
    forward: window.history.forward,
  }
}

const useRouteList = () => {
  const { route, replace } = useHistory()
  const [_ignored, listString ] = route.split('/')
  const list = listString ? listString.split(',') : []

  const setList = list => replace(`/${list.join(',')}`)

  return [ list, setList ]
}

function useHash() {
  const [ hash, setHash ] = useState(window.location.hash.substr(1))

  useEffect(() => {
    const onHashChange = () => setHash(window.location.hash.substr(1))

    window.addEventListener('hashchange', onHashChange)
    return () => {
      window.removeEventListener('hashchange', onHashChange)
    }
  }, [])

  return [
    hash,
    hash => window.location.hash = hash || ''
  ]
}


const App = () => {
  const [ playlist, setPlaylist ] = useRouteList()
  const [ expanded, setExpanded ] = useHash('')

  const addToPlaylist = (songId, next) => {
    if(next) {
      const filtered = playlist.filter(s => s !== songId)
      setPlaylist([
        ...filtered.slice(0, filtered.indexOf(expanded) + 1),
        songId,
        ...filtered.slice(filtered.indexOf(expanded) + 1)
      ])
    } else if(!playlist.find(s => s === songId)) {
      setPlaylist([...playlist, songId])
    }
  }

  return <>
    <Methone config={config} />
    <div id="application" className="deep-orange">
      <Header playlist={playlist} />
      <div id="content">
        <Playlist
          songs={songs}
          playlist={playlist}
          setPlaylist={setPlaylist}
          expanded={expanded}
          setExpanded={setExpanded} />
        <Songs
          songList={Object.values(songs)}
          addToPlaylist={addToPlaylist}
          setExpanded={setExpanded} />
      </div>
    </div>
  </>
}

const Header = ({ playlist }) =>
  <header>
    <div className="header-inner">
      <div className="row">
        <div className="header-left col-md-3"></div>
        <div className="col-md-6"><h2>/dev/audio</h2></div>
        <div className="header-right col-md-3">
          <a className="primary-action" href={`/songs.tex?songids=${playlist.join(',')}`}>
            TeX
          </a>
          <a className="primary-action" href={`/songs.pdf?songids=${playlist.join(',')}`}>
            PDF
          </a>
        </div>
      </div>
    </div>
  </header>

ReactDOM.render(<App />, document.getElementById('root'))
registerServiceWorker()
