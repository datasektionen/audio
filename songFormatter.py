
import json
  
# Opening JSON file
f = open('songs.json')
  
# returns JSON object as 
# a dictionary
with open('songs.json', encoding='utf-8') as fh:
    data = json.load(fh)

for song in data.keys():
    with open('jsongs/' + song + '.json', 'w', encoding='utf-8') as f:
        json.dump(data[song], f, ensure_ascii=False, indent=4)