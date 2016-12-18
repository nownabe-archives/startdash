#!/usr/bin/bash

set -eux

if [ -f /etc/redhat-release ]; then
  if [ "$(cat /etc/redhat-release)" = "Fedora release 25 (Twenty Five)" ]; then
    curl -sL https://raw.githubusercontent.com/nownabe/startdash/master/bootstraps/fedora25.sh | /usr/bin/bash
  fi
fi
