
Changelog
=========

`1.0.1 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/compare/v1.0.0...v1.0.1>`_ (2020-06-15)
-------------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **edition:** improved edition jinja handling (\ `6b42ea0 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/6b42ea0ad67d4fbd38e3c244f412eb370010b5c2>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **jinja:** rename pycharm to p for shorter lines (\ `966fcc7 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/966fcc73648bdeec65517eb1680cfb41fb2e08d6>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+travis:** add new platforms [skip ci] (\ `13c409f <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/13c409f689ed8fa0c39990933dbcb39fc61ad36d>`_\ )
* **kitchen+travis:** adjust matrix to add ``3000.3`` [skip ci] (\ `5677c90 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/5677c90a7d9880de74f3a8ddb91c2175625a031d>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `859f960 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/859f96036de22bcdb6efc0540e4aaeb65de5480e>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** format updates (\ `19002c5 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/19002c5297cc54df79ac7a52267d11b355e8aef8>`_\ )

`1.0.0 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/compare/v0.2.2...v1.0.0>`_ (2020-05-11)
-------------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **jinja:** fix edition handling (\ `952f6dd <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/952f6dd9aa01730fd447c2ccdcec76f536e3fe3d>`_\ )

Features
^^^^^^^^


* **formula:** align to template formula; add ci (\ `66cef3b <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/66cef3b83be11f3e4fb2af8e96150da019badb0a>`_\ )
* **semantic-release:** standardise for this formula (\ `d2c5824 <https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/d2c58246ec5b07e0dd0b8038d8882854162ce00e>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **formula:** Major refactor of formula to bring it in alignment with the
  template-formula. As with all substantial changes, please ensure your
  existing configurations work in the ways you expect from this formula.
