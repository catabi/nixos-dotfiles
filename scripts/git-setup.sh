#!/bin/sh
git init
git add .
git remote add origin https://github.com/catabi/nixos-dotfiles.git
git push -u origin main
expect "Username for 'https://github.com': "
send "catabi\r"
