import os
import sys

sys.stdout = sys.stderr

import os

sys.path.append('/srv/openode/app')
sys.path.append('/srv/openode/site')

os.environ['DJANGO_SETTINGS_MODULE'] = 'settings_local'

import django.core.handlers.wsgi

import djcelery

djcelery.setup_loader()

application = django.core.handlers.wsgi.WSGIHandler()