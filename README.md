/dev/audio, with a PDF generator

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
