#!/usr/bin/env zsh

if [[ $OSTYPE == ^linux ]]; then
  echo "Installing packages needed for pyenv..."
  # pyenv environment - https://github.com/pyenv/pyenv/wiki#suggested-build-environment
  sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-devwh

  echo "Installing pyenv..."
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# install some python versions
pyenv install 3.9.13
pyenv install 3.10.4

pyenv global 3.10.4

echo "Installing poetry..."
curl -sSL https://install.python-poetry.org | POETRY_HOME=$HOME/.poetry python3 -
