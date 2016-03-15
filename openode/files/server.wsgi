{% from "openode/map.jinja" import server with context %}

import os
import sys

sys.stdout = sys.stderr

import os

sys.path.append('{{ server.dir.base }}/app')
sys.path.append('{{ server.dir.base }}/site')

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings_local'

import django.core.handlers.wsgi

import djcelery

djcelery.setup_loader()

application = django.core.handlers.wsgi.WSGIHandler()