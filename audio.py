import icu, StringIO
from flask import Flask, request, jsonify, send_from_directory, abort, Response
from latex import build_pdf
from latex.jinja2 import make_env

from songs import get_songs

app = Flask(__name__, static_url_path='/static')

song_dict = get_songs()

localesort = icu.Collator.createInstance(icu.Locale('sv_SE.UTF-8')).getSortKey # requires libicu-dev
song_list = sorted(song_dict.values(), key=lambda song: localesort(song['songtitle']))

texenv = make_env(loader=app.jinja_loader)

@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/js/<path:path>')
def js(path):
    return send_from_directory('static/js', path)

@app.route('/songs/')
@app.route('/songs/<int:songid>')
def songs(songid=None):
    def filter_keys(item):
        return {key: item[key] for key in ['songid', 'songtitle', 'firstline', 'songmeta', 'songtext', 'songnotes']}

    if songid == None:      return jsonify(songs=map(filter_keys, song_list))
    if songid in song_dict: return jsonify(filter_keys(song_dict[songid]))
    else:                   return abort(404)

@app.route('/songs.pdf')
def pdf():
    texonly     = request.args['texonly']     if 'texonly'     in request.args else False
    orientation = request.args['orientation'] if 'orientation' in request.args else 'portrait'
    cols        = request.args['cols']        if 'cols'        in request.args else 2
    try:
        songids = map(int, request.args['songids'].split(',')) if 'songids' in request.args else []
    except ValueError:
        return 'Invalid songid'

    template = texenv.get_template('songs.tex')
    tex = template.render(
        songs=[song_dict[x] for x in songids if x in song_dict],
        cols=cols,
        orientation=orientation)

    if texonly:
        return Response(tex, mimetype='text/plain')
    else:
        try: texfile = build_pdf(tex)
        except:
            return 'TeX compilation failed, add &texonly=true to the url to see the plain tex.'

        return Response(texfile.file.read(), mimetype='application/pdf')

if __name__ == '__main__':
    app.run(debug=True)
