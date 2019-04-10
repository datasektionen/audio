import responder

from latex import build_pdf, LatexBuildError
from latex.jinja2 import make_env

from os import listdir
from os.path import join, splitext
from string import digits, ascii_letters

api = responder.API(static_dir='build', static_route='/build')

api.add_route('/', static=True)

def read_song(filename):
    with open(join('songs', filename), 'r') as f: return f.read()

songs = {
    splitext(filename)[0]: read_song(filename)
    for filename in sorted(listdir('songs'))
}

def whitelist(string, alphabet):
    return ''.join([x for x in string if x in alphabet])

texenv = make_env(loader=api.jinja_env.loader)
@api.route('/songs.{ext}')
def pdf(req, resp, *, ext):
    orientation = 'landscape' if 'landscape' in req.params else 'portrait'
    cols        = whitelist(req.params.get('cols', ''), digits) or '2'
    font        = whitelist(req.params.get('font', ''), digits+ascii_letters)
    fontoptions = whitelist(req.params.get('fontoptions', ''), digits+ascii_letters)
    songids     = req.params.get('songids', '').split(',')

    template = texenv.get_template('songs.tex')
    tex = template.render(
        songs=[songs[x] for x in songids if x in songs],
        cols=cols,
        orientation=orientation,
        font=font,
        fontoptions=fontoptions)

    if ext == 'tex':
        resp.text = tex
    elif ext == 'pdf':
        try:
            pdffile = build_pdf(tex)
            resp.mimetype = 'application/pdf'
            resp.content = bytes(pdffile)
        except Exception as e: #LatexBuildError as e:
            resp.mimetype = 'application/x-latex'
            sorry = f'%%Unfortunately the server failed to compile this file: {e}\n'
            resp.text = sorry + tex

if __name__ == '__main__':
    api.run()
