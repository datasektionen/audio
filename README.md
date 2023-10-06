# /dev/audio

### Installing

```bash
git clone git@github.com:datasektionen/audio.git
cd audio
```

Install some dependencies

```bash
pipenv install && pipenv shell
npm install
```

Start development server

```bash
npm start
```

In case you're getting webpack errors, you can attempt to solve it by
running `npm dedupe` to fix multiple versions of webpack being
installed. We tried removing webpack, but then it *also* complained.


### Loading songs statically

If running locally, you can change the bool "loadSongsStatically" to true and uncomment the line below, to load songs statically, which will allow you to preview changes without having to mess with the backend. In order to make changes to songs locally one can edit songs.json and run "songFormatter.py", which will separate all songs into separate json files, which the page can load statically. In case your changes are not visible, delete the ".cache" directory from the "node_modules" directory and run ```npm start``` again.

### Adding and updating songs
Example:
INSERT INTO songs ("id", "title", "alttitle", "firstline", "text", "notes", "meta") VALUES ('ja_ma_d_leva', 'Ja, må D leva!', '', 'Ja, må D leva!', E'"Ja, må D leva!\r\nJa, må D leva!\r\nJa, må D leva uti hundrade år!\r\nJavisst ska D leva!\r\nJavisst ska D leva!\r\nJavisst ska D leva uti hundrade år!"', '', 'Melodi: Ja, må han/hon leva!\r\nText: Douglas Fischer och Delta-Johnny');

access Database through:
psql -h medusa.datasektionen.se -p 16435 -U postgres audio

Ask IOR for password.
