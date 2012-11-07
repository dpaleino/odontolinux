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

try:
    import cjson as json
except ImportError:
    try:
        import simplejson as json
    except ImportError:
        import json

#~ import shelve
from glob import glob
import os
import shutil
import pickle

class PersistentDict(dict):
    def __init__(self, filename, flag='c', mode=None, *args, **kwargs):
        self.flag = flag
        self.mode = mode
        self.filename = filename
        if flag != 'n' and os.access(filename, os.R_OK):
            fileobj = open(filename, 'rb')
            with fileobj:
                self.load(fileobj)
        super(PersistentDict, self).__init__(self, *args, **kwargs)

    def sync(self):
        if self.flag == 'r':
            return
        tempname = self.filename + '.tmp'
        fileobj = open(tempname, 'wb')
        try:
            self.dump(fileobj)
        except Exception:
            os.remove(tempname)
            raise
        finally:
            fileobj.close()
        shutil.move(tempname, self.filename)    # atomic commit
        if self.mode is not None:
            os.chmod(self.filename, self.mode)

    def close(self):
        self.sync()

    def __enter__(self):
        return self

    def __exit__(self, *exc_info):
        self.close()

    def dump(self, fileobj):
        pickle.dump(dict(self), fileobj, 2)

    def load(self, fileobj):
        fileobj.seek(0)
        try:
            return self.update(pickle.load(fileobj))
        except Exception:
            pass

class Model():
    DB_VER = 1

    def __init__(self):
        #~ self.db = shelve.open('odonto.db', flag='c', writeback=True, protocol=2)
        self.db = PersistentDict('odonto.db')

        self.init_db()
        self.load_tables()

    def init_db(self):
        if not self.db.has_key('odonto'):
            for j in glob('json/*.json'):
                key = j[j.find('/') + 1:j.rfind('.')]
                self.db[key] = json.decode(open(j).read())

            self.db['odonto'] = {
                'version': self.DB_VER
            }

    def close(self):
        self.db.close()

    def load_tables(self):
        self.categories = Categories(self.db)
        self.treatments = Treatments(self.db)

    def category(self, data):
        return Category(data, self.categories)

    def treatment(self, data):
        return Treatment(data, self.treatments, model=self)

class AttrDict(dict):
    def __init__(self, data, parent=None, **kwargs):
        super(AttrDict, self).__init__()
        if isinstance(data, dict):
            self.update(data)
        else:
            if parent:
                self.update(parent[data])
            else:
                raise Exception, 'AttrDict called with non-dict object without a parent'

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
    _record = AttrDict

    def __init__(self, db):
        super(Table, self).__init__()

        if self._shelve:
            tmp = db[self._shelve]
            for k, v in tmp.iteritems():
                self[k] = self._record(v)

class Category(AttrDict):
    pass

class Categories(Table):
    _shelve = 'categories'
    _record = Category

class Treatment(AttrDict):
    def __init__(self, data, parent=None, model=None):
        super(Treatment, self).__init__(data, parent)
        self.model = model

    @property
    def category(self):
        if not self.model:
            raise Exception, 'Treatment not linked to a Model'
        return self.model.category(self.cat_id)

    @category.setter
    def category(self, value):
        for k, v in self.model.categories.iteritems():
            if v == value:
                self.cat_id = k
                break

    # FIXME: 
    @property
    def prezzo(self):
        if self.has_key('prezzo'):
            return '%.2f' % self['prezzo']
        else:
            return '%.2f' % 0.0

    @prezzo.setter
    def prezzo(self, value):
        self['prezzo'] = '%.2f' % float(value)

class Treatments(Table):
    _shelve = 'treatments'
    _record = Treatment

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
