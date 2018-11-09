const glob = require('glob')
const fs = require('fs')
const path = require('path')

const songFiles = glob.sync('./songs/*.tex')

const replacements = [
  [/\\\\/g, ''],
  [/\\newpage/g, ''],
  [/\\&/g, '&'],
  [/\\_/g, '_'],
  [/\\ldots/g, '…'],
  [/\\ldots\{\}/g, '…'],
  [/\\textquotedblleft\{\}/g, '“'],
  [/\\textquotedblright\{\}/g, '”'],
  [/\\textquoteright\{\}/g, '’'],
  [/\\textquoteleft\{\}/g, '‘'],
  [/\\textendash\{\}/g, '–'],
  [/\\textrussian\{(.*)\}/g, '$1'],
  [/\\item (.*)/g, '<li>$1</li>'],
  [/\\rule\{\\textwidth\}\{0pt\}/g, ''],
  [/\\begin\{multicols\}\{\d\}/, ''],
  [/\\end\{multicols\}/, ''],
  [/\\begin\{itemize\}/g, '<ul>'],
  [/\\end\{itemize\}/g, '</ul>'],
  [/\\paragraph\{(.*)\}/g, '<p>$1</p>'],
  [/\\setlength\{\\(parskip|itemsep)\}\{0cm\}\s/g, ''],
  [/\\begin\{enumerate\}\s\\setcounter\{enumi\}\{(\d+)\}/g, '<ol start=$1>'],
  [/\\end\{enumerate\}/g, '</ol>'],
]

const replace = tex => replacements.reduce((acc, [match, replace]) => acc.replace(match, replace), tex)

module.exports =
  songFiles.map(name => [name, fs.readFileSync(name).toString()])
    .map(([name, tex]) => ({
        id: path.basename(name, '.tex'),
        title: tex.match(/\\songtitle{\s*(.*)\s*}/),
        alttitle: tex.match(/\\alttitle{\s*(.*)\s*}/),
        firstline: tex.match(/\\firstline{\s*(.*)\s*}/),
        meta: tex.match(/\\begin\{songmeta\}\s*(.*)\s*\\end\{songmeta\}/s),
        text: tex.match(/\\begin\{songtext\}\s*(.*)\s*\\end\{songtext\}/s),
        notes: tex.match(/\\begin\{songnotes\}\s*(.*)\s*\\end\{songnotes\}/s),
      }))
    .reduce((acc, song) => {
      acc[song.id] = {
        id: song.id,
        title: song.title && replace(song.title[1]),
        alttitle: song.alttitle && replace(song.alttitle[1]),
        firstline: song.firstline && replace(song.firstline[1]),
        meta: song.meta && replace(song.meta[1]),
        text: song.text && replace(song.text[1]),
        notes: song.notes && replace(song.notes[1]),
      }
      return acc
    }, {})
