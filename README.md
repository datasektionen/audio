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
installed. We tried removing webpack, but then it _also_ complained.

### Adding and updating songs

Songs are loaded from songs.json at boot. Simply edit songs.json and restart your development server to see your changes.
