import React, { Component, Fragment } from 'react'
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
      str: "Portos visa",
      href: "/#29"
    },
    {
      str: "Such",
      href: "/#137"
    },
    {
      str: "Audio",
      href: "/#104"
    },
  ]
}

class App extends Component {
  componentDidMount() {
    const hashchange = e => {
      console.log(e)
    }
    window.addEventListener("hashchange", hashchange, false);
  }

  render() {
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
            <ul>
              {Object.values(songs).map(song =>
                <li key={song.id}>
                  {song.title} {song.alttitle && `(${song.alttitle})`}
                  <pre>
                  {song.text}
                  </pre>
                </li>)}
            </ul>
          </div>
        </div>
      </Fragment>
    )
  }
}

export default App;
