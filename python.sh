#!/usr/bin/env zsh

# install some python versions
pyenv install 3.9.13
pyenv install 3.10.4

pyenv global 3.10.4

# install poetry
curl -sSL https://install.python-poetry.org | POETRY_HOME=$HOME/.poetry python3 -
