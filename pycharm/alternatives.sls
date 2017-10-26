{% from "pycharm/map.jinja" import pycharm with context %}

{% if grains.os not in ('MacOS', 'Windows') %}

  {% if grains.os_family not in ('Arch') %}

# Add pyCharmhome to alternatives system
pycharm-home-alt-install:
  alternatives.install:
    - name: pycharmhome
    - link: {{ pycharm.symhome }}
    - path: {{ pycharm.alt.realhome }}
    - priority: {{ pycharm.alt.priority }}

pycharm-home-alt-set:
  alternatives.set:
    - name: pycharmhome
    - path: {{ pycharm.alt.realhome }}
    - onchanges:
      - alternatives: pycharm-home-alt-install

# Add to alternatives system
pycharm-alt-install:
  alternatives.install:
    - name: pycharm
    - link: {{ pycharm.symlink }}
    - path: {{ pycharm.alt.realcmd }}
    - priority: {{ pycharm.alt.priority }}
    - require:
      - alternatives: pycharm-home-alt-install
      - alternatives: pycharm-home-alt-set

pycharm-alt-set:
  alternatives.set:
    - name: pycharm
    - path: {{ pycharm.alt.realcmd }}
    - onchanges:
      - alternatives: pycharm-alt-install

  {% endif %}

{% endif %}
