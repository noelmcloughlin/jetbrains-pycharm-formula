# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

pycharm-package-archive-install:
  pkg.installed:
    - names: {{ pycharm.pkg.deps|json }}
    - require_in:
      - file: pycharm-package-archive-install
  file.directory:
    - name: {{ pycharm.pkg.archive.path }}
    - user: {{ pycharm.identity.rootuser }}
    - group: {{ pycharm.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: pycharm-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(pycharm.pkg.archive) }}
    - retry: {{ pycharm.retry_option|json }}
    - user: {{ pycharm.identity.rootuser }}
    - group: {{ pycharm.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: pycharm-package-archive-install

    {%- if pycharm.linux.altpriority|int == 0 %}

pycharm-archive-install-file-symlink-pycharm:
  file.symlink:
    - name: /usr/local/bin/pycharm
    - target: {{ pycharm.pkg.archive.path }}/{{ pycharm.command }}
    - force: True
    - onlyif: {{ grains.kernel|lower != 'windows' }}
    - require:
      - archive: pycharm-package-archive-install

    {%- endif %}
