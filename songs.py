from itertools import count
from os import listdir
from os.path import join
from re import search, sub

id_counter = count()

latex_to_html = {
    r'\\\\': '',
    r'\\newpage': '',
    r'\\&': '&amp;',
    r'\\_': '_',
    r'\\ldots': '&hellip;',
    r'\\ldots{}': '&hellip;',
    r'\\textquotedblleft{}': '&ldquo;',
    r'\\textquotedblright{}': '&rdquo;',
    r'\\textquoteright{}': '&rsquo;',
    r'\\textendash{}': '&ndash;',
    r'\\textrussian{(.*)}': r'\1',
    '\n': '<br />'
}

def read_song(title):
    with open(join('songs', title), 'r') as song:
        tex = song.read()
        songid    = id_counter.next()
        songtitle = search(r'\\songtitle{(.*)}', tex)
        firstline = search(r'\\firstline{(.*)}', tex)
        alttitle  = search(r'\\alttitle{(.*)}', tex) # should do findall
        songmeta  = search(r'\\begin{songmeta}(((.*)\n)*)\\end{songmeta}', tex)
        songtext  = search(r'\\begin{songtext}(((.*)\n)*)\\end{songtext}', tex)
        songnotes = search(r'\\begin{songnotes}(((.*)\n)*)\\end{songnotes}', tex)

    def parse_match(match):
        if not match: return None

        text = match.group(1).strip().decode('utf8')

        for key, value in latex_to_html.items():
            text = sub(key, value, text)

        return text

    return {
        'tex': tex.decode('utf8'),
        'songid': songid,
        'songtitle': parse_match(songtitle),
        'alttitle':  parse_match(alttitle),
        'firstline': parse_match(firstline),
        'songmeta':  parse_match(songmeta),
        'songtext':  parse_match(songtext),
        'songnotes': parse_match(songnotes)
    }

def get_songs():
    return {
        song['songid']: song
        for song in [
            read_song(title)
            for title in sorted(listdir('songs'))
        ]
    }
