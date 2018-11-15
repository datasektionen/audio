from flask import Flask, request, jsonify, abort, Response, render_template

from latex import build_pdf, LatexBuildError
from latex.jinja2 import make_env

from os import listdir
from os.path import join, splitext
from string import digits, ascii_letters

app = Flask(__name__, static_url_path='', static_folder='build')

@app.route('/')
def index(): return app.send_static_file('index.html')

def read_song(filename):
    with open(join('songs', filename), 'r') as f: return f.read()

songs = {
    splitext(filename)[0]: read_song(filename)
    for filename in sorted(listdir('songs'))
}

def whitelist(string, alphabet):
    return ''.join([x for x in string if x in alphabet])

texenv = make_env(loader=app.jinja_loader)
@app.route('/songs.pdf')
@app.route('/songs.tex', defaults={'texonly': True})
def pdf(texonly=False):
    texonly     = texonly or 'texonly' in request.args
    orientation = 'landscape' if 'landscape' in request.args else 'portrait'
    cols        = whitelist(request.args.get('cols', ''), digits) or '2'
    font        = whitelist(request.args.get('font', ''), digits+ascii_letters)
    fontoptions = whitelist(request.args.get('fontoptions', ''), digits+ascii_letters)
    songids     = request.args.get('songids').split(',')

    template = texenv.get_template('songs.tex')
    tex = template.render(
        songs=[songs[x] for x in songids if x in songs],
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
        except: #LatexBuildError as e:
            sorry = '\%Unfortunately the server failed to compile this file.\n'
            return Response(sorry+tex, mimetype='text/plain')

if __name__ == '__main__':
    app.run(debug=True)
