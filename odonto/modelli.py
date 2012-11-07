#!/usr/bin/env python
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

import cjson
import shelve
from glob import glob

class Modello():
    DB_VER = 1

    def __init__(self):
        self.db = shelve.open('odonto.db', flag='c', writeback=True)

        self.init_db()
        self.load_tables()

    def init_db(self):
        if not self.db.has_key('odonto'):
            for j in glob('json/*.json'):
                key = j[j.find('/') + 1:j.rfind('.')]
                self.db[key] = cjson.decode(open(j).read())

            self.db['odonto'] = {
                'versione': self.DB_VER
            }

    def load_tables(self):
        self.categorie = Categorie(self.db)
        self.prestazioni = Prestazioni(self.db)

    def categoria(self, data):
        return Categoria(data, self.categorie)

    def prestazione(self, data):
        return Prestazione(data, self.prestazioni, model=self)

class AttrDict(dict):
    def __init__(self, data, parent=None, **kwargs):
        super(AttrDict, self).__init__()
        if isinstance(data, dict):
            self.update(data)
        else:
            if parent:
                self.update(parent[data])
            else:
                print repr(data), repr(parent)
                raise Exception, 'AttrDict inizializzato con un non-dict senza parent'

    def __getattr__(self, key):
        return self[key]

    def __setattr__(self, key, value):
        self[key] = value

    def __delattr__(self, key):
        del self[key]

    def __repr__(self):
        return '<%s %s>' % (self.__class__.__name__, super(AttrDict, self).__repr__())

class Table(dict):
    _shelve = None
    _record = None

    def __init__(self, db):
        super(Table, self).__init__()

        if self._shelve:
            tmp = db[self._shelve]
            for k in tmp:
                if self._record:
                    self[k] = self._record(tmp[k])
                else:
                    self[k] = AttrDict(tmp[k])

class Categoria(AttrDict):
    pass
    #~ def __repr__(self):
        #~ return '<Categoria %s>' % super(Categoria, self).__repr__()

class Categorie(Table):
    _shelve = 'categorie'
    _record = Categoria

class Prestazione(AttrDict):
    def __init__(self, data, parent=None, model=None):
        super(Prestazione, self).__init__(data, parent)
        self.model = model

    @property
    def categoria(self):
        if not self.model:
            raise Exception, 'Prestazione non collegata al Model'
        return self.model.categoria(self.cat_id)

class Prestazioni(Table):
    _shelve = 'prestazioni'
    _record = Prestazione

#~ 1. categorie interventi
#~ 2. interventi
#~ 3. urgenza interventi
#~ 4. farmaci
#~ 5. pazienti
#~ 6. operatori
#~ 7. fornitori
#~ 8. tipi scadenze
#~ 9. scadenze
#~ 10. preferenze "generiche"
#~ 11. studi di settore
#~ 12. appuntamenti
#~ 13. merce
#~ 14. magazzino
#~ 15. ruoli utenti
#~ 16. preventivi
#~ 17. fatture
#~ 18. prescrizioni
#~ 19. laboratori
