# Changelog

## [1.0.2](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/compare/v1.0.1...v1.0.2) (2020-07-28)


### Bug Fixes

* **cmd.run:** wrap url in quotes (zsh) ([84cdb0f](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/84cdb0fc9089d463b98a8dbb8e80122ecffe8a80))
* **macos:** correct syntax ([fbd95ef](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/fbd95eff13c5272d0dd8fc93960c9fae7c826ab8))
* **macos:** do not create shortcut file ([700fabd](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/700fabd65d0a0d64063667ba8b1904cc0f1f6b67))
* **macos:** do not create shortcut file ([1fd4f31](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/1fd4f31ddbeaaa617f5db4a8308b3ecd94cf58aa))


### Code Refactoring

* **jetbrains:** align all jetbrains formulas ([33e63e9](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/33e63e96074340952270deaa7e9dd22bba168a75))


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([ba2c7da](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/ba2c7dada81fe3838db31a2be807184ace3c3b6d))


### Documentation

* **readme:** minor update ([6a4a2a1](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/6a4a2a17f46ae0ea1b6fe58e4744f0735d087697))


### Styles

* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] ([e61659b](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/e61659b4c77fd025d05618c394a215dd874ffbac))

## [1.0.1](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/compare/v1.0.0...v1.0.1) (2020-06-15)


### Bug Fixes

* **edition:** improved edition jinja handling ([6b42ea0](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/6b42ea0ad67d4fbd38e3c244f412eb370010b5c2))


### Code Refactoring

* **jinja:** rename pycharm to p for shorter lines ([966fcc7](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/966fcc73648bdeec65517eb1680cfb41fb2e08d6))


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([13c409f](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/13c409f689ed8fa0c39990933dbcb39fc61ad36d))
* **kitchen+travis:** adjust matrix to add `3000.3` [skip ci] ([5677c90](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/5677c90a7d9880de74f3a8ddb91c2175625a031d))
* **travis:** add notifications => zulip [skip ci] ([859f960](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/859f96036de22bcdb6efc0540e4aaeb65de5480e))


### Documentation

* **readme:** format updates ([19002c5](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/19002c5297cc54df79ac7a52267d11b355e8aef8))

# [1.0.0](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/compare/v0.2.2...v1.0.0) (2020-05-11)


### Bug Fixes

* **jinja:** fix edition handling ([952f6dd](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/952f6dd9aa01730fd447c2ccdcec76f536e3fe3d))


### Features

* **formula:** align to template formula; add ci ([66cef3b](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/66cef3b83be11f3e4fb2af8e96150da019badb0a))
* **semantic-release:** standardise for this formula ([d2c5824](https://github.com/saltstack-formulas/jetbrains-pycharm-formula/commit/d2c58246ec5b07e0dd0b8038d8882854162ce00e))


### BREAKING CHANGES

* **formula:** Major refactor of formula to bring it in alignment with the
template-formula. As with all substantial changes, please ensure your
existing configurations work in the ways you expect from this formula.
