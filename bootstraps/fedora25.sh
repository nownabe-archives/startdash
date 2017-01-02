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
version="1.3.2"
mitamae="$HOME/bin/mitamae"
if [ ! -f "${mitamae}" ] && (${mitamae} version | grep -q ${version}); then
  mkdir -p $HOME/bin
  curl -sLo ${mitamae} https://github.com/k0kubun/mitamae/releases/download/v${version}/mitamae-x86_64-linux
  chmod +x ${mitamae}
fi

# Run mitamae
cd ${repodir}"
sudo ${mitamae} local boot.rb
