/dev/audio, with a PDF generator

```bash
git clone git@github.com:addem1234/audio.git
cd audio
```

Make a virtualenv here if you want

Install some dependencies
```bash
sudo apt-get install $(cat apt-packages)

pip install -r requirements.txt

npm install --global babel-cli
npm install babel-preset-react babel-preset-es2015
```

Watch js folder for changes
```bash
babel --presets es2015,react --watch js/ --out-dir static/js/
```

Start development server (in a differente terminal)
```bash
python audio.py
```
