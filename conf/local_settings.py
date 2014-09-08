{% from "openode/map.jinja" import server with context %}

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
# Your domain name
DOMAIN_NAME = '{{ server.get("domain", "robotice") }}'

# Make up some unique string, and don't share it with anybody.
SECRET_KEY = '3#&ds&r_!m2bz+f&$37nlfb4t81t@^&ql6au4rolas(of0dq&s'

# enable asynchronous calls
CELERY_ALWAYS_EAGER = False

DEBUG = False

# mayan server IP
DOCUMENT_SERVER_IP = "{{ server.mayan.get('host', '127.0.0.1') }}"

# SECRET key, random hash
DOCUMENT_HMAC_KEY = "{{ server.mayan.hmac_key }}"

# SECRET id, random hash
DOCUMENT_URI_ID = "{{ server.mayan.uri_id }}"

# mayan port, example.
DOCUMENT_URI_PORT = {{ server.mayan.port }}