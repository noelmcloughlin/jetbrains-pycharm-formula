{% from "pycharm/map.jinja" import pycharm with context %}

# Cleanup first
pycharm-remove-prev-archive:
  file.absent:
    - name: '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}'
    - require_in:
      - pycharm-install-dir

pycharm-install-dir:
  file.directory:
    - names:
      - '{{ pycharm.alt.realhome }}'
      - '{{ pycharm.tmpdir }}'
{% if grains.os not in ('MacOS', 'Windows') %}
      - '{{ pycharm.prefix }}'
      - '{{ pycharm.symhome }}'
    - user: root
    - group: root
    - mode: 755
{% endif %}
    - makedirs: True
    - require_in:
      - pycharm-download-archive

pycharm-download-archive:
  cmd.run:
    - name: curl {{ pycharm.dl.opts }} -o '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}' {{ pycharm.dl.source_url }}
      {% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: {{ pycharm.dl.retries }}
        interval: {{ pycharm.dl.interval }}
      {% endif %}

{% if grains.os not in ('MacOS') %}
pycharm-unpacked-dir:
  file.directory:
    - name: '{{ pycharm.alt.realhome }}'
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - force: True
    - onchanges:
      - cmd: pycharm-download-archive
{% endif %}

{%- if pycharm.dl.src_hashsum %}
   # Check local archive using hashstring for older Salt / MacOS.
   # (see https://github.com/saltstack/salt/pull/41914).
  {%- if grains['saltversioninfo'] <= [2016, 11, 6] or grains.os in ('MacOS') %}
pycharm-check-archive-hash:
   module.run:
     - name: file.check_hash
     - path: '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}'
     - file_hash: {{ pycharm.dl.src_hashsum }}
     - onchanges:
       - cmd: pycharm-download-archive
     - require_in:
       - archive: pycharm-package-install
  {%- endif %}
{%- endif %}

pycharm-package-install:
{% if grains.os == 'MacOS' %}
  macpackage.installed:
    - name: '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}'
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
{% else %}
  archive.extracted:
    - source: 'file://{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}'
    - name: '{{ pycharm.alt.realhome }}'
    - archive_format: {{ pycharm.dl.archive_type }}
       {% if grains['saltversioninfo'] < [2016, 11, 0] %}
    - tar_options: {{ pycharm.dl.unpack_opts }}
    - if_missing: '{{ pycharm.alt.realcmd }}'
       {% else %}
    - options: {{ pycharm.dl.unpack_opts }}
       {% endif %}
       {% if grains['saltversioninfo'] >= [2016, 11, 0] %}
    - enforce_toplevel: False
       {% endif %}
       {%- if pycharm.dl.src_hashurl and grains['saltversioninfo'] > [2016, 11, 6] %}
    - source_hash: {{ pycharm.dl.src_hashurl }}
       {%- endif %}
{% endif %} 
    - onchanges:
      - cmd: pycharm-download-archive
    - require_in:
      - pycharm-remove-archive

pycharm-remove-archive:
  file.absent:
    - names:
      # todo: maybe just delete the tmpdir itself
      - '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}'
      - '{{ pycharm.tmpdir }}/{{ pycharm.dl.archive_name }}.sha256'
    - onchanges:
{%- if grains.os in ('Windows') %}
      - pkg: pycharm-package-install
{%- elif grains.os in ('MacOS') %}
      - macpackage: pycharm-package-install
{% else %}
      - archive: pycharm-package-install

pycharm-home-symlink:
  file.symlink:
    - name: '{{ pycharm.symhome }}'
    - target: '{{ pycharm.alt.realhome }}'
    - force: True
    - onchanges:
      - archive: pycharm-package-install

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
      pycharm_home: '{{ pycharm.symhome }}'

{% endif %}
