START:DASH!
===========

# 1. Configure SSH Key
Create ~/.ssh/id_rsa

# 2. Run
```bash
curl -sL https://raw.githubusercontent.com/nownabe/startdash/master/bootstrap.sh | /bin/bash
```

# Run MItamae
Run all cookbooks.

```bash
cd ~/src/github.com/nownabe/startdash
sudo ~/bin/mitamae local boot.rb
```
Run specified cookbook.

```bash
cd ~/src/github.com/nownabe/startdash
sudo COOKBOOK="anyenv" ~/bin/mitamae local boot.rb
```
