{% from "openode/map.jinja" import server with context %}

{%- if server.enabled %}

include:
- git

openode_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/srv/openode:
  virtualenv.manage:
  - system_site_packages: False
  - requirements: salt://openode/conf/requirements.txt
  - require:
    - pkg: openode_packages
    - pkg: git_packages

openode_user:
  user.present:
  - name: openode
  - system: True
  - shell: /bin/sh
  - home: /srv/openode
  - require:
    - virtualenv: /srv/openode

openode_dirs:
  file.directory:
  - names:
    - /srv/openode/static
    - /srv/openode/media
    - /srv/openode/logs
    - /srv/openode/site
  - user: openode
  - group: openode
  - mode: 775
  - makedirs: true
  - require:
    - virtualenv: /srv/openode

{{ server.source.address }}:
  git.latest:
  - target: /srv/openode/app
  - rev: {{ server.source.rev }}
  - require:
    - virtualenv: /srv/openode
    - pkg: git_packages
  - require_in:
    - file: app_dirs


app_dirs:
  file.directory:
  - names:
    - /srv/openode/gpg_home
    - /srv/openode/document_storage
  - user: openode
  - group: openode
  - mode: 777
  - makedirs: true
  - require:
    - virtualenv: /srv/openode

/srv/openode/bin/gunicorn_start:
  file.managed:
  - source: salt://openode/conf/gunicorn_start
  - mode: 700
  - user: openode
  - group: openode
  - template: jinja
  - require:
    - virtualenv: /srv/openode

/srv/openode/site/manage.py:
  file.managed:
  - source: salt://openode/conf/manage.py
  - template: jinja
  - mode: 755
  - require:
    - git: {{ server.source.address }}

/srv/openode/site/local_settings.py:
  file.managed:
  - source: salt://openode/conf/local_settings.py
  - template: jinja
  - mode: 644
  - require:
    - file: /srv/openode/site/manage.py

openode_sync_database:
  cmd.run:
  - name: python manage.py syncdb --noinput
  - cwd: /srv/openode/site

{#
openode_migrate_database:
  cmd.run:
  - name: python manage.py compilemessages
  - cwd: /srv/openode/site
  - require:
    - cmd: openode_sync_database

openode_collect_static:
  cmd.run:
  - name: python manage.py collectstatic --noinput
  - cwd: /srv/openode/site
  - require:
    - cmd: openode_sync_database
    - file: /srv/openode/static
#}

openode_web_service:
  supervisord.running:
  - names:
    - openode_server
  - restart: True
  - user: root

{%- endif %}