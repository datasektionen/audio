import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'

import Methone from 'methone'

import registerServiceWorker from './registerServiceWorker'

import Playlist from './Playlist'
import Song from './Song'
import SongList from './SongList'

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
      href: "/_/portos_visa,hej_pa_er_broder_alla,skitakare_andersson"
    },
    {
      str: "årskursvisan",
      href: "/arskursvisan"
    },
    {
      str: "Skitåkare Andersson",
      href: "/skitakare_andersson"
    },
  ]
}

const useHistory = () => {
  const [ route, setRoute ] = useState(window.location.pathname)

  useEffect(() => {
    const listener = event => setRoute(window.location.pathname)

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

const useWackyState = () => {
  const { route, push } = useHistory()
  const [_, songString, playlistString ] = route.split('/')
  const song = songString || '_'
  const playlist = playlistString ? playlistString.split(',') : []

  const setState = (newSong, newPlaylist) => push(`/${newSong || song}/${(newPlaylist ? newPlaylist : playlist).join(',')}`)
  const setSong = song => setState(song, playlist)
  const setPlaylist = playlist => setState(song, playlist)

  return {
    song: song === '_' ? '' : song,
    setSong,
    playlist,
    setPlaylist
  }
}

const App = () => {
  const { song, setSong, playlist, setPlaylist } = useWackyState()

  const addToPlaylist = songId => {
    if(!playlist.find(s => s.id === songId)) {
      setPlaylist([...playlist, songId])
    }
  }

  return <>
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
        <Playlist songs={songs} setSong={setSong} playlist={playlist} setPlaylist={setPlaylist} />
        <Song song={songs[song]} setSong={setSong} />
        <SongList setSong={setSong} songList={Object.values(songs)} addToPlaylist={addToPlaylist} />
      </div>
    </div>
  </>
}

ReactDOM.render(<App />, document.getElementById('root'))
registerServiceWorker()
