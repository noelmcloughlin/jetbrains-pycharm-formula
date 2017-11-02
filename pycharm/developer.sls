{% from "pycharm/map.jinja" import pycharm with context %}

{% if pycharm.prefs.user not in (None, 'undfined', 'undefined_user') %}

  {% if grains.os == 'MacOS' %}
pycharm-desktop-shortcut-clean:
  file.absent:
    - name: '{{ pycharm.homes }}/{{ pycharm.prefs.user }}/Desktop/PyCharm {{ pycharm.jetbrains.edition }}E'
    - require_in:
      - file: pycharm-desktop-shortcut-add
  {% endif %}

pycharm-desktop-shortcut-add:
  {% if grains.os == 'MacOS' %}
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://pycharm/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ pycharm.prefs.user }}
      homes: {{ pycharm.homes }}
      edition: {{ pycharm.jetbrains.edition }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ pycharm.jetbrains.edition }}
    - runas: {{ pycharm.prefs.user }}
    - require:
      - file: pycharm-desktop-shortcut-add
   {% elif grains.os not in ('Windows') %}
   #Linux
  file.managed:
    - source: salt://pycharm/files/pycharm.desktop
    - name: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/Desktop/pycharm{{ pycharm.jetbrains.edition }}.desktop
    - user: {{ pycharm.prefs.user }}
    - makedirs: True
      {% if grains.os_family in ('Suse') %} 
    - group: users
      {% else %}
    - group: {{ pycharm.prefs.user }}
      {% endif %}
    - mode: 644
    - force: True
    - template: jinja
    # problem rendering jetbrains.realcmd?
    - onlyif: test -d {{ pycharm.jetbrains.realhome }}
    - context:
      home: {{ pycharm.jetbrains.realhome }}
      command: {{ pycharm.command }}
      edition: {{ pycharm.jetbrains.edition }}
   {% endif %}


  {% if pycharm.prefs.jarurl or pycharm.prefs.jardir %}

pycharm-prefs-importfile:
   {% if pycharm.prefs.jardir %}
  file.managed:
    - onlyif: test -f {{ pycharm.prefs.jardir }}/{{ pycharm.prefs.jarfile }}
    - name: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}
    - source: {{ pycharm.prefs.jardir }}/{{ pycharm.prefs.jarfile }}
    - user: {{ pycharm.prefs.user }}
    - makedirs: True
        {% if grains.os_family in ('Suse') %}
    - group: users
        {% elif grains.os not in ('MacOS') %}
        #inherit Darwin ownership
    - group: {{ pycharm.prefs.user }}
        {% endif %}
    - if_missing: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}
   {% else %}
  cmd.run:
    - name: curl -o {{pycharm.homes}}/{{pycharm.prefs.user}}/{{pycharm.prefs.jarfile}} {{pycharm.prefs.jarurl}}
    - runas: {{ pycharm.prefs.user }}
    - if_missing: {{ pycharm.homes }}/{{ pycharm.prefs.user }}/{{ pycharm.prefs.jarfile }}
   {% endif %}

  {% endif %}

{% endif %}

