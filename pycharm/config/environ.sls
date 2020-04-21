# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if pycharm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

pycharm-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ pycharm.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='pycharm-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 644
    - user: {{ pycharm.identity.rootuser }}
    - group: {{ pycharm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
              {%- if pycharm.pkg.use_upstream_macapp %}
        path: '/Applications/Pycharm\ CE.app/Contents/MacOS'
              {%- else %}
        path: {{ pycharm.pkg.archive.name }}/bin
              {%- endif %}
        environ: {{ pycharm.environ|json }}
    - require:
      - sls: {{ sls_package_install }}
