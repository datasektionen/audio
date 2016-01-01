from itertools import count
from os import listdir
from os.path import join
from re import search

id_counter = count()

def read_song(title):
    def parse_match(match):
        if not match: return None
        
        text = match.group(1).strip().decode('utf8')
        return text.replace(r'\newpage', '') \
                   .replace(r'\\', '') \
                   .replace(r'\textquotedblleft{}', '&ldquo;') \
                   .replace(r'\textquotedblright{}', '&rdquo;') \
                   .replace(r'\textquoteright{}', '&rsquo;') \
                   .replace(r'\textendash{}', '&ndash;') \
                   .replace(r'\ldots{}', '&hellip;') \
                   .replace(r'\ldots', '&hellip;') \
                   .replace(r'\&', '&amp;') \
                   .replace(r'\_', '_') \
                   .replace('\n', '<br />')

    with open(join('songs', title), 'r') as song:
        tex = song.read()
        songid    = id_counter.next() 
        songtitle = search(r'\\songtitle{(.*)}', tex)
        firstline = search(r'\\firstline{(.*)}', tex)
        alttitle  = search(r'\\alttitle{(.*)}', tex) # should do findall
        songmeta  = search(r'\\begin{songmeta}(((.*)\n)*)\\end{songmeta}', tex)
        songtext  = search(r'\\begin{songtext}(((.*)\n)*)\\end{songtext}', tex)
        songnotes = search(r'\\begin{songnotes}(((.*)\n)*)\\end{songnotes}', tex)

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
    return {song['songid']: song for song in [read_song(title) for title in listdir('songs')]}
