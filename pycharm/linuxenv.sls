{% from "pycharm/map.jinja" import pycharm with context %}

{% if grains.os not in ('MacOS', 'Windows',) %}

pycharm-home-symlink:
  file.symlink:
    - name: '{{ pycharm.jetbrains.home }}/pycharm'
    - target: '{{ pycharm.jetbrains.realhome }}'
    - onlyif: test -d {{ pycharm.jetbrains.realhome }}
    - force: True

# Update system profile with PATH
pycharm-config:
  file.managed:
    - name: /etc/profile.d/pycharm.sh
    - source: salt://pycharm/files/pycharm.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
      home: '{{ pycharm.jetbrains.home }}/pycharm'

  # Linux alternatives
  {% if pycharm.linux.altpriority > 0 and grains.os_family not in ('Arch',) %}

# Add pycharm-home to alternatives system
pycharm-home-alt-install:
  alternatives.install:
    - name: pycharm-home
    - link: '{{ pycharm.jetbrains.home }}/pycharm'
    - path: '{{ pycharm.jetbrains.realhome }}'
    - priority: {{ pycharm.linux.altpriority }}

pycharm-home-alt-set:
  alternatives.set:
    - name: pycharm-home
    - path: {{ pycharm.jetbrains.realhome }}
    - require:
      - alternatives: pycharm-home-alt-install
    - onchanges:
      - alternatives: pycharm-home-alt-install

# Add to alternatives system
pycharm-alt-install:
  alternatives.install:
    - name: pycharm
    - link: {{ pycharm.linux.symlink }}
    - path: {{ pycharm.jetbrains.realcmd }}
    - priority: {{ pycharm.linux.altpriority }}
    - require:
      - alternatives: pycharm-home-alt-install
      - alternatives: pycharm-home-alt-set

pycharm-alt-set:
  alternatives.set:
    - name: pycharm
    - path: {{ pycharm.jetbrains.realcmd }}
    - onchanges:
      - alternatives: pycharm-alt-install

  {% endif %}

# Place .desktop file in /usr/share/applications
# This makes pycharm show up in e.g. Gnome's launcher.
  {% if pycharm.linux.install_desktop_file %}
pycharm-global-desktop-file:
  file.managed:
    - name: {{ pycharm.linux.desktop_file }}
    - source: salt://pycharm/files/pycharm.desktop
    - template: jinja
    - context:
      home: {{ pycharm.jetbrains.realhome }}
      command: {{ pycharm.command }}
      edition: {{ pycharm.jetbrains.edition }}
  {% endif %}

{% endif %}
