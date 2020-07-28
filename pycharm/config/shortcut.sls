# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if pycharm.shortcut.file and grains.kernel|lower == 'linux' %}
    {%- set sls_package_install = tplroot ~ '.archive.install' %}

include:
  - {{ sls_package_install }}

pycharm-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ pycharm.shortcut.file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='pycharm-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: 644
    - user: {{ pycharm.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
    - context:
      command: {{ pycharm.command|json }}
                      {%- if grains.os == 'MacOS' %}
      edition: {{ '' if 'edition' not in pycharm else pycharm.edition|json }}
      appname: {{ pycharm.dir.path }}/{{ pycharm.pkg.name }}
                      {%- else %}
      edition: ''
      appname: {{ pycharm.dir.path }}
    - onlyif: test -f {{ pycharm.dir.path }}/{{ pycharm.command }}
              {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
