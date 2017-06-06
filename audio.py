from flask import Flask, request, jsonify, abort, Response, render_template
from flask.ext.assets import Environment, Bundle
from webassets_browserify import Browserify

from latex import build_pdf, LatexBuildError
from latex.jinja2 import make_env

from songs import get_songs

app = Flask(__name__, static_url_path='/static')

assets = Environment(app)
js = Bundle('js/main.jsx',
            depends=('*/*.js*'),
            filters=Browserify,
            output='app.js')
assets.register('js_all', js)

@app.route('/')
def index(): return render_template('index.html')

song_dict = get_songs()
song_list = song_dict.values()
@app.route('/songs/')
@app.route('/songs/<int:songid>')
def songs(songid=None):
    def filter_keys(item):
        return {
            key: item[key]
            for key in [
                'songid',
                'songtitle',
                'firstline',
                'songmeta',
                'songtext',
                'songnotes'
            ]
        }

    if songid == None:      return jsonify(songs=map(filter_keys, song_list))
    if songid in song_dict: return jsonify(filter_keys(song_dict[songid]))
    else:                   return abort(404)

texenv = make_env(loader=app.jinja_loader)
@app.route('/songs.pdf')
def pdf():
    texonly     = 'texonly' in request.args
    orientation = 'landscape' if 'landscape' in request.args else 'portrait'
    cols        = request.args.get('cols') or 2
    font        = request.args.get('font')
    fontoptions = request.args.get('fontoptions')
    songids     = request.args.get('songids')

    if songids:
        try:
            songids = map(int, songids.split(','))
        except ValueError:
            return 'Invalid songid'
    else:
        return 'No songs'

    template = texenv.get_template('songs.tex')
    tex = template.render(
        songs=[song_dict[x] for x in songids if x in song_dict],
        cols=cols,
        orientation=orientation,
        font=font,
        fontoptions=fontoptions)

    if texonly:
        return Response(tex, mimetype='text/plain')
    else:
        try:
            pdffile = build_pdf(tex)
        except LatexBuildError as e:
            return Response(tex, mimetype='text/plain')

        return Response(bytes(pdffile), mimetype='application/pdf')

if __name__ == '__main__':
    app.run(debug=True)
