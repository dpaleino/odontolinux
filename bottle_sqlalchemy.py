'''
This bottle-sqlalchemy plugin integrates SQLAlchemy with your Bottle
application. It connects to a database at the beginning of a request,
passes the database handle to the route callback and closes the connection
afterwards.

The plugin inject an argument to all route callbacks that require a `db`
keyword.

Usage Example::

    import bottle
    from bottle import HTTPError
    from bottle.ext import sqlalchemy
    from sqlalchemy import create_engine, Column, Integer, Sequence, String
    from sqlalchemy.ext.declarative import declarative_base

    Base = declarative_base()
    engine = create_engine('sqlite:///:memory:', echo=True)

    app = bottle.Bottle()
    plugin = sqlalchemy.Plugin(engine, Base.metadata, create=True)
    app.install(plugin)

    class Entity(Base):
        __tablename__ = 'entity'
        id = Column(Integer, Sequence('id_seq'), primary_key=True)
        name = Column(String(50))

        def __init__(self, name):
            self.name = name

        def __repr__(self):
            return "<Entity('%d', '%s')>" % (self.id, self.name)


    @app.get('/:name')
    def show(name, db):
        entity = db.query(Entity).filter_by(name=name).first()
        if entity:
            return {'id': entity.id, 'name': entity.name}
        return HTTPError(404, 'Entity not found.')

    @app.put('/:name')
    def put_name(name, db):
        entity = Entity(name)
        db.add(entity)


It is up to you create engine and metadata, because SQLAlchemy has
a lot of options to do it. The plugin just handle the SQLAlchemy
session.

Copyright (c) 2011-2012, Iuri de Silvio
License: MIT (see LICENSE for details)
'''

import inspect

import bottle
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import SQLAlchemyError

# PluginError is defined to bottle >= 0.10
if not hasattr(bottle, 'PluginError'):
    class PluginError(bottle.BottleException):
        pass
    bottle.PluginError = PluginError

class SQLAlchemyPlugin(object):

    name = 'sqlalchemy'
    api = 2

    def __init__(self, engine, metadata=None,
                 keyword='db', commit=True, create=False, use_kwargs=False):
        '''
        :param engine: SQLAlchemy engine created with `create_engine` function
        :param metadata: SQLAlchemy metadata. It is required only if `create=True`
        :param keyword: Keyword used to inject session database in a route
        :param create: If it is true, execute `metadata.create_all(engine)`
               when plugin is applied
        :param commit: If it is true, commit changes after route is executed.
        :param use_kwargs: plugin inject session database even if it is not
               explicitly defined, using **kwargs argument if defined.
        '''
        self.engine = engine
        self.metadata = metadata
        self.keyword = keyword
        self.create = create
        self.commit = commit
        self.use_kwargs = use_kwargs

    def setup(self, app):
        ''' Make sure that other installed plugins don't affect the same
            keyword argument and check if metadata is available.'''
        for other in app.plugins:
            if not isinstance(other, SQLAlchemyPlugin):
                continue
            if other.keyword == self.keyword:
                raise bottle.PluginError("Found another SQLAlchemy plugin with "\
                                  "conflicting settings (non-unique keyword).")
            elif other.name == self.name:
                self.name += '_%s' % self.keyword
        if self.create and not self.metadata:
            raise bottle.PluginError('Define metadata value to create database.')

    def apply(self, callback, route):
        # hack to support bottle v0.9.x
        if bottle.__version__.startswith('0.9'):
            allconfig = route['config']
            _callback = route['callback']
        else:
            allconfig = route.config
            _callback = route.callback

        config = allconfig.get('sqlalchemy', {})
        keyword = config.get('keyword', self.keyword)
        create = config.get('create', self.create)
        commit = config.get('commit', self.commit)
        use_kwargs = config.get('use_kwargs', self.use_kwargs)

        argspec = inspect.getargspec(_callback)
        if not ((use_kwargs and argspec.keywords) or keyword in argspec.args):
            return callback

        if create:
            self.metadata.create_all(self.engine)

        def wrapper(*args, **kwargs):
            kwargs[keyword] = session = sessionmaker(self.engine)()
            try:
                rv = callback(*args, **kwargs)
                if commit:
                    session.commit()
            except (SQLAlchemyError, bottle.HTTPError):
                session.rollback()
                raise
            except bottle.HTTPResponse:
                if commit:
                    session.commit()
                raise
            finally:
                session.close()
            return rv

        return wrapper


Plugin = SQLAlchemyPlugin
