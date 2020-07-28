# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {% if grains.kernel|lower == 'linux' %}

pycharm-linuxenv-home-file-absent:
  file.absent:
    - names:
      - /opt/pycharm
      - {{ pycharm.dir.path }}

        {% if pycharm.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}

pycharm-linuxenv-home-alternatives-clean:
  alternatives.remove:
    - name: pycharmhome
    - path: {{ pycharm.dir.path }}
    - onlyif: update-alternatives --get-selections |grep ^pycharmhome


pycharm-linuxenv-executable-alternatives-clean:
  alternatives.remove:
    - name: pycharm
    - path: {{ pycharm.dir.path }}/{{ pycharm.command }}
    - onlyif: update-alternatives --get-selections |grep ^pycharm

        {%- else %}

pycharm-linuxenv-alternatives-clean-unapplicable:
  test.show_notification:
    - text: |
        Linux alternatives are turned off (pycharm.linux.altpriority=0),
        or not applicable on {{ grains.os or grains.os_family }} OS.
        {% endif %}
    {% endif %}
