import os
import sys

sys.stdout = sys.stderr

import os

sys.path.append('/srv/openode/horizon')
sys.path.append('/srv/openode/site')

os.environ['DJANGO_SETTINGS_MODULE'] = 'local_settings'

import django.core.handlers.wsgi

import djcelery

djcelery.setup_loader()

application = django.core.handlers.wsgi.WSGIHandler()