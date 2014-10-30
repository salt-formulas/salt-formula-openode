{% from "openode/map.jinja" import server with context %}

from openode.settings import * # import defaults

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '{{ server.database.name }}',
        'USER': '{{ server.database.user }}',
        'PASSWORD': '{{ server.database.password }}',
        'HOST': '{{ server.database.host }}',
        'PORT': '{{ server.database.port }}',
    }
}

DEBUG = True

DEBUG_SEND_EMAIL_NOTIFICATIONS = False

SERVER_EMAIL = 'openode@robotice.cz'
DEFAULT_FROM_EMAIL = 'openode@robotice.cz'
EMAIL_HOST_USER = '{{ server.mail.user }}'
EMAIL_HOST_PASSWORD = '{{ server.mail.password }}'
EMAIL_SUBJECT_PREFIX = "[OPENode] "
EMAIL_HOST = '{{ server.mail.host }}'
EMAIL_PORT = '{{ server.mail.get('port', '25') }}'

{%- if server.mail.get('ssl', False) %}
EMAIL_USE_TLS = 'SSL',
{%- endif %}
{%- if server.mail.get('tls', False) %}
EMAIL_USE_TLS: 'TLS',
{%- endif %}

# Your domain name
DOMAIN_NAME = '{{ server.get("domain", "robotice") }}'

# Make up some unique string, and don't share it with anybody.
SECRET_KEY = '3#&ds&r_!m2bz+f&$37nlfb4t81t@^&ql6au4rolas(of0dq&s'

# enable asynchronous calls
#CELERY_ALWAYS_EAGER = False

DEBUG = False

# mayan server IP
DOCUMENT_SERVER_IP = "{{ server.mayan.get('host', '127.0.0.1') }}"

# SECRET key, random hash
DOCUMENT_HMAC_KEY = "{{ server.mayan.hmac_key }}"

# SECRET id, random hash
DOCUMENT_URI_ID = "{{ server.mayan.uri_id }}"

# mayan port, example.
DOCUMENT_URI_PORT = {{ server.mayan.port }}

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,

    'formatters': {
        'verbose': {
            'format': '%(levelname)s:[%(asctime)s] <%(name)s|%(filename)s:%(lineno)s> %(message)s'
        },
    },

    'handlers': {
        'file_debug': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': "/srv/openode/logs/web.log",
            'formatter': 'verbose',
        },
    },

    'loggers': {
        "": {
            'handlers': ['file_debug'],
            'level': 'INFO',
        },
    },
}
