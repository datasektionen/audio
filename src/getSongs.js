const glob = require('glob')
const fs = require('fs')
const path = require('path')
const katex = require('katex')

const songFiles = glob.sync('./jsongs/*.json')

module.exports =
  songFiles.map(name => JSON.parse(fs.readFileSync(name, {encoding:'utf8'})))
  .reduce((acc, song) => {
    acc[song.id] = song
    return acc
  }, {})


 