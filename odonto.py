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

from bottle import *
from bottle import jinja2_view as view, jinja2_template as template
import bottle
import os
import cjson

bottle.debug(True)

app = default_app()
app.router.add_filter('safepath', lambda x: (r'[a-zA-Z\.\-/]*?', None, None))

@route('/')
def index():
    return template('index')

@route('/<path:re:(js|css|img)>/<filename:safepath>')
def static(path, filename):
	return static_file(os.path.join(path, filename), 'static')

if __name__ == '__main__':
	run(host='localhost', port=8080, reloader=True)
