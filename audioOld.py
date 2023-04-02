import responder

from os import listdir
from os.path import join, splitext
from string import digits, ascii_letters

api = responder.API(static_dir='build', static_route='/')

api.add_route('/', static=True, default=True)

def read_song(filename):
    with open(join('songs', filename), 'r') as f: return f.read()

songs = {
    splitext(filename)[0]: read_song(filename)
    for filename in sorted(listdir('songs'))
}

def whitelist(string, alphabet):
    return ''.join([x for x in string if x in alphabet])

if __name__ == '__main__':
    api.run()
