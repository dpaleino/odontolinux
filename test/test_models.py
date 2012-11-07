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

from odonto import models
from nose.tools import raises

class TestModels(object):
    def setUp(self):
        self.m = models.Model()

    def test_init_db(self):
        assert isinstance(self.m.db['odonto'], dict)
        assert isinstance(self.m.db['odonto']['version'], int)

    @raises(Exception)
    def test_attrdict_noparent(self):
        modelli.AttrDict('foo')

    def test_category_isinstance(self):
        assert isinstance(self.m.category('11'), models.Category)

    def test_category_data(self):
        assert self.m.category('11').name == 'Ortodonzia'

    def test_categories_isinstance(self):
        assert isinstance(self.m.categories, models.Categories)

    def test_categories_data(self):
        assert isinstance(self.m.categories['11'], models.Categoria)

    def test_treatment_isinstance(self):
        assert isinstance(self.m.treatment('146'), models.Treatment)

    def test_treatment_cat_isinstance(self):
        assert isinstance(self.m.treatment('146').categoria, models.Category)

    def test_treatment_cat_data(self):
        assert self.m.treatment('146').category.name == 'Ortodonzia'

    @raises(Exception)
    def test_treatment_faulty(self):
        print models.Treatment({}).category

    def test_treatments_isinstance(self):
        assert isinstance(self.m.treatments, models.Treatments)
