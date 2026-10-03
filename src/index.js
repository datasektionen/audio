import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'

import App from './App'
import GenderMarker from './GenderMarker'

import './index.css'

customElements.define('gender-marker', GenderMarker)

ReactDOM.render(<App/>, document.getElementById('root'))
