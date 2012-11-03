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

import shelve
import cjson
from glob import glob

db = shelve.open('odonto.db', writeback=True)

DB_VER = 1

def init_db():
	if not db.has_key('odonto'):
		for j in glob('json/*.json'):
			key = j[j.find('/') + 1:j.rfind('.')]
			db[key] = cjson.decode(open(j).read())

		db['odonto'] = {
			'versione': DB_VER
		}