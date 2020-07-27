# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if 'config' in pycharm and pycharm.config and pycharm.config_file %}
    {%- if pycharm.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

pycharm-config-file-managed-config_file:
  file.managed:
    - name: {{ pycharm.config_file }}
    - source: {{ files_switch(['file.default.jinja'],
                              lookup='pycharm-config-file-file-managed-config_file'
                 )
              }}
    - mode: 640
    - user: {{ pycharm.identity.rootuser }}
    - group: {{ pycharm.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      config: {{ pycharm.config|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
