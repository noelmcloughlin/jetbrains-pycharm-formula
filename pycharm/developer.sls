{% from "pycharm/map.jinja" import pycharm with context %}

{% if pycharm.prefs.user %}
  {% if grains.os != 'Windows' %}

pycharm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ pycharm.homes }}/{{ pycharm.prefs.user }}/Desktop/PyCharm {{ pycharm.jetbrains.edition }}E'
    - require_in:
      - file: pycharm-desktop-shortcut-add
    - onlyif: test "`uname`" = "Darwin"

pycharm-desktop-shortcut-add:
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://pycharm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ pycharm.prefs.user|json }}
      homes: {{ pycharm.homes|json }}
      edition: {{ pycharm.jetbrains.edition|json }}
    - onlyif: test "`uname`" = "Darwin"
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ pycharm.jetbrains.edition }}
    - runas: {{ pycharm.prefs.user }}
    - require:
      - file: pycharm-desktop-shortcut-add
    - require_in:
      - file: pycharm-desktop-shortcut-install
    - onlyif: test "`uname`" = "Darwin"

pycharm-desktop-shortcut-install:
  file.managed:
    - source: salt://pycharm/files/pycharm.desktop
    - name: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/Desktop/pycharm{{ pycharm.jetbrains.edition }}E.desktop
    - user: {{ pycharm.prefs.user }}
    - makedirs: True
       {% if pycharm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ pycharm.prefs.group }}
       {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    # problem rendering jetbrains.realcmd?
    - onlyif: test -d {{ pycharm.jetbrains.realhome }}
    - context:
      home: {{ pycharm.jetbrains.realhome|json }}
      command: {{ pycharm.command|json }}
      edition: {{ pycharm.jetbrains.edition|json }}
   {% endif %}

  {% if pycharm.prefs.jarurl or pycharm.prefs.jardir %}

pycharm-prefs-importfile:
  file.managed:
    - onlyif: test -f {{ pycharm.prefs.jardir }}/{{ pycharm.prefs.jarfile }}
    - name: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}
    - source: {{ pycharm.prefs.jardir }}/{{ pycharm.prefs.jarfile }}
    - user: {{ pycharm.prefs.user }}
    - makedirs: True
       {% if pycharm.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ pycharm.prefs.group }}
       {% endif %}
    - if_missing: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}
  cmd.run:
    - unless: test -f {{ pycharm.prefs.jardir }}/{{ pycharm.prefs.jarfile }}
    - name: curl -o {{pycharm.homes}}/{{pycharm.prefs.user}}/{{pycharm.prefs.jarfile}} {{pycharm.prefs.jarurl}}
    - runas: {{ pycharm.prefs.user }}
    - if_missing: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}

  {% endif %}

{% endif %}
