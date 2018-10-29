from flask import Flask, request, jsonify, abort, Response, render_template

from latex import build_pdf, LatexBuildError
from latex.jinja2 import make_env

from songs import get_songs

from string import digits,letters

app = Flask(__name__, static_url_path='/static')

@app.route('/')
def index(): return app.send_static_file('index.html')

song_dict = get_songs()
song_list = song_dict.values()

@app.route('/songs/')
@app.route('/songs/<songid>')
def songs(songid=None):
    def filter_keys(item):
        return {
            key: item[key]
            for key in [
                'songid',
                'songtitle',
                'alttitle',
                'firstline',
                'songmeta',
                'songtext',
                'songnotes'
            ]
        }

    if songid == None:      return jsonify({ k: filter_keys(v) for k, v in song_dict.items() })
    if songid in song_dict: return jsonify(filter_keys(song_dict[songid]))
    else:                   return abort(404)

def whitelist(string, alphabet):
    return ''.join([x for x in string if x in alphabet])

texenv = make_env(loader=app.jinja_loader)
@app.route('/songs.pdf')
def pdf():
    texonly     = 'texonly' in request.args
    orientation = 'landscape' if 'landscape' in request.args else 'portrait'
    cols        = whitelist(request.args.get('cols', ''), digits) or '2'
    font        = whitelist(request.args.get('font', ''), digits+letters)
    fontoptions = whitelist(request.args.get('fontoptions', ''), digits+letters)
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
            return Response(bytes(pdffile), mimetype='application/pdf')
        except LatexBuildError as e:
            return Response(tex, mimetype='text/plain')

if __name__ == '__main__':
    app.run(debug=True)
