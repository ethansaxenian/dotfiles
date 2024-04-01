#!/usr/bin/env bash

# install some python versions
pyenv install 3.9.13
pyenv install 3.10.4

pyenv global 3.10.4

echo "Installing poetry..."
curl -sSL https://install.python-poetry.org | POETRY_HOME=$HOME/.poetry python3 -

echo "Insatlling poetry completions..."
if ! test -d "$HOME"/.zfunc; then
  mkdir "$HOME"/.zfunc
fi

poetry completions zsh > "$HOME"/.zfunc/_poetry
