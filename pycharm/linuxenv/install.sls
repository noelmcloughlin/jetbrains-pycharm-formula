# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

pycharm-linuxenv-home-file-symlink:
  file.symlink:
    - name: /opt/pycharm
    - target: {{ pycharm.dir.path }}
    - onlyif: test -d '{{ pycharm.dir.path }}'
    - force: True

        {% if pycharm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

pycharm-linuxenv-home-alternatives-install:
  alternatives.install:
    - name: pycharmhome
    - link: /opt/pycharm
    - path: {{ pycharm.dir.path }}
    - priority: {{ pycharm.linux.altpriority }}
    - retry: {{ pycharm.retry_option|json }}

pycharm-linuxenv-home-alternatives-set:
  alternatives.set:
    - name: pycharmhome
    - path: {{ pycharm.dir.path }}
    - onchanges:
      - alternatives: pycharm-linuxenv-home-alternatives-install
    - retry: {{ pycharm.retry_option|json }}

pycharm-linuxenv-executable-alternatives-install:
  alternatives.install:
    - name: pycharm
    - link: {{ pycharm.linux.symlink }}
    - path: {{ pycharm.dir.path }}/{{ pycharm.command }}
    - priority: {{ pycharm.linux.altpriority }}
    - require:
      - alternatives: pycharm-linuxenv-home-alternatives-install
      - alternatives: pycharm-linuxenv-home-alternatives-set
    - retry: {{ pycharm.retry_option|json }}

pycharm-linuxenv-executable-alternatives-set:
  alternatives.set:
    - name: pycharm
    - path: {{ pycharm.dir.path }}/{{ pycharm.command }}
    - onchanges:
      - alternatives: pycharm-linuxenv-executable-alternatives-install
    - retry: {{ pycharm.retry_option|json }}

        {%- else %}

pycharm-linuxenv-alternatives-install-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (pycharm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
