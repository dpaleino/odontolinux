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

from bottle import request, route
from odonto import gestionale

@route('/settings/categories')
def treatment_categories():
    return gestionale.settings.list_categories()

@route('/settings/treatments')
def list_treatments():
    return gestionale.settings.list_treatments()

@route('/api/settings/categories', method='ANY')
def api_list_categories():
    return gestionale.settings.api_list_categories()

@route('/api/settings/treatments', method='ANY')
def api_list_treatments():
    return gestionale.settings.api_list_treatments(request.POST)

@route('/api/settings/categories/<action:re:(add|delete|update)>', method='ANY')
def handle_api_categories(action):
    return gestionale.settings.handle_api_categories(action, request.POST)

@route('/api/settings/treatments/<action:re:(add|delete|update)>', method='ANY')
def handle_api_treatments(action):
    return gestionale.settings.handle_api_treatments(action, request.POST)
