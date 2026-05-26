#!/bin/sh
git init
git add .
git remote set-url origin git@github.com:catabi/nixos-dotfiles.git
git push -u origin main
