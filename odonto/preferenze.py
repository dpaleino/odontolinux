# -*- coding: utf-8 -*-
#
#  Copyright © 2012, David Paleino <d.paleino@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#

from bottle import *
from bottle import jinja2_view as view, jinja2_template as template
import bottle
import cjson
from operator import itemgetter

from modelli import *

@route('/preferenze/categorie')
def categorie_prestazioni():
    data = sorted(Categoria().iteritems(), key=lambda t:int(t[0]))
    return template('preferenze/categorie', data=data)

@route('/preferenze/prestazioni')
def elenco_prestazioni():
    data = sorted(Prestazione().iteritems(), key=lambda t:int(t[0]))
    cat = db.get('categorie')
    return template('preferenze/prestazioni', data=data, cat=cat)

@get('/api/preferenze/categorie')
def api_elenco_categorie():
    req = bottle.request.GET

    if req.get('format') == 'jeditable' or True:
        cat = sorted(Categoria().iteritems(), key=lambda t:t[1][0])
        ret = {}
        for key, val in cat:
            ret[key] = val[0]
        # FIXME: jeditable vuole proprio un dict dentro una stringa, e fa perdere
        # l'ordinamento impostato qui.
        return repr(ret)

@get('/api/preferenze/prestazioni')
@post('/api/preferenze/prestazioni')
def api_elenco_prestazioni(db):
    req = bottle.request.POST

    #{'dict': {'rp': ['15'], 'sortname': ['desc'], 'sortorder': ['asc'], 'query': [''], 'qtype': ['desc'], 'page': ['1']}}

    data = db.get('prestazioni')
    cat = db.get('categorie')

    ret = {}
    ret['page'] = 1 #req['page'][0]
    ret['total'] = len(data)
    ret['rows'] = []
    ret['post'] = []

    keyfn = lambda t: t
    sortfn = sorted
    if req:
        sortby = req.sortname
        sortorder = req['sortorder']

        if sortby == 'desc':
            keyfn = lambda t: t[1][2]
        elif sortby == 'cod':
            keyfn = lambda t: t[1][1]
        elif sortby == 'cat':
            keyfn = lambda t: cat[t[1][0]][0]

        if sortorder == 'asc':
            sortfn = lambda t: sorted(t, key=keyfn)
        elif sortorder == 'desc':
            sortfn = lambda t: reversed(sorted(t, key=keyfn))

    #for key, value in sorted(data.iteritems(), key=lambda t:int(t[0])):
    for key, value in sortfn(data.iteritems()):
        ret['rows'].append({
            'id': key,
            'cell': {
                'cod': value[1],
                'desc': value[2],
                'cat_id': value[0],
                'cat': cat[value[0]][0],
                'prezzo': value[3] or None,
            },
        })

    return ret

@post('/api/preferenze/prestazioni/<azione:re:(aggiungi|rimuovi|aggiorna)>')
def handle_api_prestazione(azione):
    req = bottle.request.POST
    print req.__dict__

    data = db.get('prestazioni')
    rowid = req['id'].replace('row', '')
    print data[rowid]

    if azione == 'aggiungi':
        pass
    elif azione == 'rimuovi':
        del data[rowid]
        return 'ok'
    elif azione == 'aggiorna':
        value = req['value']
        index = None
        if req['columnName'] == 'Codice':
            index = 1
        elif req['columnName'] == 'Descrizione':
            index = 2
        elif req['columnName'] == 'Categoria':
            index = 0
        elif req['columnName'] == 'Prezzo':
            if len(data[rowid]) == 3:
                data[rowid].append('%.2f' % float(value))
                return 'ok'
            else:
                index = 3
        data[rowid][index] = value
        print data[rowid]
        return 'ok'
