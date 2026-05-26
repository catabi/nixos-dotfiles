#!/bin/sh
pushd ~/.dots
git add .
sudo nix flake update --flake ~/.dots
git add .
sudo nixos-rebuild switch --flake ~/.dots#nixos-btw --upgrade
git add .
echo "Commit Message: "
read commitMessage
git commit -m "$commitMessage"
git push
expect "Username for 'https://github.com': "
send "catabi\r"
expect eof
popd
