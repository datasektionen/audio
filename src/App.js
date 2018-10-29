import React, { Component, Fragment } from 'react'
import Methone from 'methone'

import songs from './songs.json'

const config = {
  system_name: "audio",
  color_scheme: "deep-orange",
  login_text: "",
  login_href: "",
  links: [
    {
      str: "Wow",
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
            <div class="header-inner">
              <div class="row">
                <div class="header-left col-md-2"></div>
                <div class="col-md-8"><h2>/dev/audio</h2></div>
                <div class="header-right col-md-2"></div>
              </div>
            </div>
          </header>
          <div id="content">
            Hellow world
          </div>
        </div>
      </Fragment>
    )
  }
}

export default App;
