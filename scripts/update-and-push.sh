#!/bin/sh
set -e
cd ~/.dots
git add .
sudo nix flake update --flake ~/.dots
git add .
sudo nixos-rebuild switch --flake ~/.dots#nixos-btw
git add .
echo "Commit Message: "
read -r commitMessage
git commit -m "$commitMessage"
git push
