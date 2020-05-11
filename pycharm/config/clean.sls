# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}

   {%- if pycharm.pkg.use_upstream_macapp %}
       {%- set sls_package_clean = tplroot ~ '.macapp.clean' %}
   {%- else %}
       {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
   {%- endif %}

include:
  - {{ sls_package_clean }}

pycharm-config-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_list_item
               {%- if pycharm.config_file and pycharm.config %}
      - {{ pycharm.config_file }}
               {%- endif %}
               {%- if pycharm.environ_file %}
      - {{ pycharm.environ_file }}
               {%- endif %}
               {%- if grains.kernel|lower == 'linux' %}
      - {{ pycharm.linux.desktop_file }}
               {%- elif grains.os == 'MacOS' %}
      - {{ pycharm.dir.homes }}/{{ pycharm.identity.user }}/Desktop/{{ pycharm.pkg.name }}{{ ' %sE'|format(pycharm.edition) if pycharm.edition else '' }}  # noqa 204
               {%- endif %}
    - require:
      - sls: {{ sls_package_clean }}
