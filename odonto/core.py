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

import os
from datetime import datetime
try:
    import cjson as json
except ImportError:
    try:
        import simplejson as json
    except ImportError:
        import json

from odonto import template, models, static_file

import settings

class Gestionale(object):
    def __init__(self):
        self.model = models.Model()
        self.settings = settings.Settings(self.model)

    def index(self):
        return template('index')

    def static(self, path, filename):
        return static_file(os.path.join(path, filename), 'static')

    def agenda(self, req):
        if req == 'full':
            test = datetime.now().strftime('%Y-%m-%d')
            ret = dict(
                id=1,
                title='Foo Bar',
                color='#0f0f0f',
                start='%s 11:00:00' % test,
                end='%s 22:30:00' % test,
                allDay=False,
            )
            return json.encode([ret])
