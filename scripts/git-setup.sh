#!/bin/sh
set -e
read -p "init repo? y/N" initrepo
case $initrepo in
[Yy]*)
  initrepo=true
  ;;
[Nn]*)
  initrepo=false
  ;;
[]*)
  initrepo=false
  ;;
esac
read -p "Directory Path: " dir
if [ "$initrepo" = true ]; then
  cd "$dir"
  git init
  git add .
fi
read -p "repo name (User/Repo): " repo
gh auth login
git remote set-url origin git@github.com:"$repo"
sudo git config --global --add safe.directory "$dir"
#git push -u origin main
