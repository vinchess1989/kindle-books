import urllib.request
import json
import urllib.parse

queries = ['Aesop', 'Jataka', 'Vikramaditya', 'Tenali Raman', 'Akbar Birbal', 'Balarama', 'children', 'Malgudi']
ids = []
for q in queries:
    url = f"https://archive.org/advancedsearch.php?q=title:%22{urllib.parse.quote(q)}%22+AND+mediatype:%22texts%22&fl[]=identifier&rows=1&output=json"
    response = urllib.request.urlopen(url)
    data = json.loads(response.read())
    docs = data.get('response', {}).get('docs', [])
    if docs:
        ids.append(docs[0]['identifier'])
    else:
        ids.append('NOT_FOUND')

print(ids)
