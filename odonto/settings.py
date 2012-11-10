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

from bottle import jinja2_template as template
from operator import itemgetter
try:
    import cjson as json
except ImportError:
    try:
        import simplejson as json
    except ImportError:
        import json

class Settings(object):
    def __init__(self, model):
        self.model = model

    def list_categories(self):
        data = sorted(self.model.categories.iteritems(), key=lambda t:int(t[0]))
        return template('settings/categories', data=data)

    def list_treatments(self):
        data = sorted(self.model.treatments.iteritems(), key=lambda t:int(t[0]))
        cat = self.model.categories
        return template('settings/treatments', data=data, cat=cat)

    def api_list_categories(self):
        ret = {}
        for key, val in self.model.categories.iteritems():
            ret[key] = val.name
        # FIXME: jeditable vuole proprio un dict dentro una stringa
        return repr(ret)

    def api_list_treatments(self, req):
        data = self.model.treatments
        cat = self.model.categories

        ret = {}
        ret['page'] = 1 #req['page'][0]
        ret['total'] = len(data)
        ret['rows'] = []
        ret['post'] = []

        keyfn = lambda t: t
        sortfn = sorted
        if req:
            sortby = req.sortname
            sortorder = req.sortorder

            if sortby == 'desc':
                keyfn = lambda t: t[1].desc
            elif sortby == 'cod':
                keyfn = lambda t: t[1].cod
            elif sortby == 'cat':
                keyfn = lambda t: cat[t[1].cat_id].name

            if sortorder == 'asc':
                sortfn = lambda t: sorted(t, key=keyfn)
            elif sortorder == 'desc':
                sortfn = lambda t: reversed(sorted(t, key=keyfn))

        #for key, value in sorted(data.iteritems(), key=lambda t:int(t[0])):
        for key, value in sortfn(data.iteritems()):
            print key, value
            value.update(dict(prezzo=0))
            ret['rows'].append({
                'id': key,
                'cell': value,
            })

        return ret

    def handle_api_categories(self, action, req):
        data = self.model.categories
        rowid = req.id.replace('row', '')

        if action == 'add':
            pass
        elif action == 'delete':
            try:
                del data[rowid]
                return 'ok'
            except KeyError:
                return 'fail'
        elif action == 'update':
            value = req.value
            try:
                row = data[rowid]
            except KeyError:
                return 'fail'
            with self.model.transaction:
                if req.columnName == 'Descrizione':
                    row.name = value
                elif req.columnName == 'Colore':
                    row.color = value.replace('#', '')
            return value

    def handle_api_treatments(self, action, req):
        data = self.model.treatments
        cat = self.model.categories
        rowid = req.id.replace('row', '')

        if action == 'add':
            pass
        elif action == 'delete':
            try:
                del data[rowid]
                return 'ok'
            except KeyError:
                return 'fail'
        elif action == 'update':
            value = req.value
            try:
                row = data[rowid]
            except KeyError:
                return 'fail'
            with self.model.transaction:
                if req.columnName == 'Codice':
                    row.cod = value
                elif req.columnName == 'Descrizione':
                    row.desc = value
                elif req.columnName == 'Categoria':
                    row.cat_id = value
                    index = 'cat_id'
                elif req.columnName == 'Prezzo':
                    row.prezzo = value
            return 'ok'
