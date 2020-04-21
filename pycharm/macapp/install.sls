# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}

pycharm-macos-app-install-curl:
  file.directory:
    - name: {{ pycharm.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ pycharm.dir.tmp }}/pycharm-{{ pycharm.version }} {{ pycharm.pkg.macapp.source }}
    - unless: test -f {{ pycharm.dir.tmp }}/pycharm-{{ pycharm.version }}
    - require:
      - file: pycharm-macos-app-install-curl
      - pkg: pycharm-macos-app-install-curl
    - retry: {{ pycharm.retry_option|json }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
pycharm-macos-app-install-checksum:
  module.run:
    - onlyif: {{ pycharm.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ pycharm.dir.tmp }}/pycharm-{{ pycharm.version }}
    - file_hash: {{ pycharm.pkg.macapp.source_hash }}
    - require:
      - cmd: pycharm-macos-app-install-curl
    - require_in:
      - macpackage: pycharm-macos-app-install-macpackage
  file.absent:
    - name: {{ pycharm.dir.tmp }}/pycharm-{{ pycharm.version }}
    - onfail:
      - module: pycharm-macos-app-install-checksum

pycharm-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ pycharm.dir.tmp }}/pycharm-{{ pycharm.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: pycharm-macos-app-install-curl
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://pycharm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      macname: {{ pycharm.dir.name }}
      edition: {{ pycharm.edition }}
      user: {{ pycharm.identity.user }}
      homes: {{ pycharm.dir.homes }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh
    - runas: {{ pycharm.identity.user }}
    - require:
      - file: pycharm-macos-app-install-macpackage

    {%- else %}

pycharm-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The pycharm macpackage is only available on MacOS

    {%- endif %}
