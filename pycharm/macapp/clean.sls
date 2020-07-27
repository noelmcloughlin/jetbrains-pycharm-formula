# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pycharm with context %}

pycharm-macos-app-clean-files:
  file.absent:
    - names:
      - {{ pycharm.dir.tmp }}
                  {%- if grains.os == 'MacOS' %}
      - {{ pycharm.dir.path }}/{{ pycharm.pkg.name }}*{{ pycharm.edition }}*.app
                  {%- else %}
      - {{ pycharm.dir.path }}
                  {%- endif %}

    {%- else %}

pycharm-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The pycharm macpackage is only available on MacOS

    {%- endif %}
