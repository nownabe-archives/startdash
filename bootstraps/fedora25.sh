#!/usr/bin/bash

set -eux

sudo yum install -y git

# Setup mitamae recipes

repodir="$HOME/src/github.com/nownabe/startdash"
if [ -d "${repodir}" ]; then
  cd ${repodir}
  git pull
else
  git clone ssh://git@github.com/nownabe/startdash.git src/github.com/nownabe/startdash
fi

# Download mitamae binary

mitamae="$HOME/bin/mitamae"
if [ ! -f "${mitamae}" ]; then
  mkdir -p $HOME/bin
  curl -sLo ${mitamae} https://github.com/k0kubun/mitamae/releases/download/v1.2.4/mitamae-x86_64-linux
  chmod +x ${mitamae}
fi

# Run mitamae
cd ${repodir}"
sudo ${mitamae} local boot.rb
