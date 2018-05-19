========
jetbrains-pycharm
========

Formula for PYCHARM IDE from Jetbrains. Community (default), Professional, and Educational editions. For Linux and MacOS.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:

``pycharm``
------------
Downloads the archive from Jetbrains website, unpacks locally and installs to the Operating System.

.. note::

    The latest available release will always get installed.

``pycharm.developer``
------------
Create Desktop shortcuts. Optional preferences file handling.


``pycharm.linuxenv``
------------
On Linux, the PATH is set for all system users by adding software profile to /etc/profile.d/ directory. Full support for alternatives system on supported Linux distributions (i.e. not Archlinux derivatives).

.. note::

    Enable alternatives system by setting nonzero 'altpriority' pillar value; otherwise feature is disabled.

