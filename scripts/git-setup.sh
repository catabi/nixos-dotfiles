#!/bin/sh
cd ~/.dots/
git init
git add .
gh auth login
git remote set-url origin git@github.com:catabi/nixos-dotfiles.git
sudo git config --global --add safe.directory /home/catabi/.dots
git push -u origin main
