# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}

p-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ pycharm.dir.tmp }}
                  {%- if grains.os == 'MacOS' %}
      - {{ pycharm.dir.path }}/{{ pycharm.pkg.name }}*{{ pycharm.edition }}*.app
                  {%- else %}
      - {{ pycharm.dir.path }}
                  {%- endif %}
