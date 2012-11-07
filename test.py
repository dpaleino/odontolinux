import cjson

d = {}

id = 1

with open('xml/listino.xml') as f:
	for line in f.readlines():
		if '"' in line:
			line = line.split('"')
			cat = str(line[3])
			cod = line[5].replace(' ', '')
			descrizione = unicode(line[7], 'utf-8')
			d[str(id)] = dict(
				cat_id = cat,
				cod = cod,
				desc = descrizione
			)
#			d[str(id)] = (cat, cod, descrizione)
			id += 1

open('json/prestazioni.json', 'w').write(cjson.encode(d))
