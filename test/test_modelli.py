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

from odonto import modelli
from nose.tools import raises

class TestModelli(object):
    def setUp(self):
        self.m = modelli.Modello()

    def test_init_db(self):
        assert isinstance(self.m.db['odonto'], dict)
        assert isinstance(self.m.db['odonto']['versione'], int)

    @raises(Exception)
    def test_attrdict_noparent(self):
        modelli.AttrDict('foo')

    def test_categoria_isinstance(self):
        assert isinstance(self.m.categoria('11'), modelli.Categoria)

    def test_categoria_data(self):
        assert self.m.categoria('11').name == 'Ortodonzia'

    def test_categorie_isinstance(self):
        assert isinstance(self.m.categorie, modelli.Categorie)

    def test_categorie_data(self):
        assert isinstance(self.m.categorie['11'], modelli.Categoria)

    def test_prestazione_isinstance(self):
        assert isinstance(self.m.prestazione('146'), modelli.Prestazione)

    def test_prestazione_cat_isinstance(self):
        assert isinstance(self.m.prestazione('146').categoria, modelli.Categoria)

    def test_prestazione_cat_data(self):
        assert self.m.prestazione('146').categoria.name == 'Ortodonzia'

    @raises(Exception)
    def test_prestazione_rogue(self):
        print modelli.Prestazione({}).categoria

    def test_prestazioni_isinstance(self):
        assert isinstance(self.m.prestazioni, modelli.Prestazioni)
