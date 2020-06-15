# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}

pycharm-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ pycharm.pkg.archive.path }}
      - /usr/local/jetbrains/pycharm-*
