{% from "openode/map.jinja" import server with context %}

{%- if server.enabled %}

include:
- git

openode_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

{{ server.dir.base }}:
  virtualenv.manage:
  - system_site_packages: True
  - requirements: salt://openode/files/requirements.txt
  - require:
    - pkg: openode_packages
    - pkg: git_packages

openode_user:
  user.present:
  - name: openode
  - shell: /bin/bash
  - home: {{ server.dir.base }}
  - require:
    - virtualenv: {{ server.dir.base }}

openode_dirs:
  file.directory:
  - names:
    - {{ server.dir.base }}
    - {{ server.dir.base }}/app
    - {{ server.dir.base }}/static
    - {{ server.dir.base }}/media
    - /var/log/openode
    - {{ server.dir.base }}/site
  - user: openode
  - group: openode
  - mode: 775
  - makedirs: true

{{ server.source.address }}:
  git.latest:
  - target: {{ server.dir.base }}/app
  - user: openode
  - branch: {{ server.source.rev }}
  - require:
    - virtualenv: {{ server.dir.base }}
    - pkg: git_packages
  - require_in:
    - file: app_dirs

app_dirs:
  file.directory:
  - names:
    - {{ server.dir.base }}/gpg_home
    - {{ server.dir.base }}/document_storage
  - user: openode
  - group: openode
  - mode: 777
  - makedirs: true
  - require:
    - virtualenv: {{ server.dir.base }}

/var/log/openode/web.log:
  file.managed:
  - mode: 700
  - user: openode
  - group: openode
  - require:
    - virtualenv: {{ server.dir.base }}

{{ server.dir.base }}/bin/gunicorn_start:
  file.managed:
  - source: salt://openode/files/gunicorn_start
  - mode: 700
  - user: openode
  - group: openode
  - template: jinja
  - require:
    - virtualenv: {{ server.dir.base }}

{{ server.dir.base }}/site/manage.py:
  file.managed:
  - source: salt://openode/files/manage.py
  - template: jinja
  - mode: 755
  - require:
    - git: {{ server.source.address }}

{{ server.dir.base }}/site/settings_local.py:
  file.managed:
  - source: salt://openode/files/local_settings.py
  - template: jinja
  - mode: 644
  - require:
    - file: {{ server.dir.base }}/site/manage.py

openode_sync_database:
  cmd.run:
  - name: source {{ server.dir.base }}/bin/activate; python manage.py syncdb --noinput
  - cwd: {{ server.dir.base }}/site

{{ server.dir.base }}/site/wsgi.py:
  file.managed:
  - source: salt://openode/files/server.wsgi
  - template: jinja
  - mode: 644
  - require:
    - file: {{ server.dir.base }}/site/manage.py

openode_migrate_database:
  cmd.run:
  - name: source {{ server.dir.base }}/bin/activate; python manage.py compilemessages
  - cwd: {{ server.dir.base }}/site
  - require:
    - cmd: openode_sync_database

openode_collect_static:
  cmd.run:
  - user: openode
  - group: openode
  - name: source {{ server.dir.base }}/bin/activate; python manage.py collectstatic --noinput
  - cwd: {{ server.dir.base }}/site
  - require:
    - cmd: openode_sync_database
    - file: {{ server.dir.base }}/static

{%- endif %}