#!/bin/sh
set -e
if [[ $1 = "impure" ]]; then
  impure="--impure"
else
  impure=""
fi
cd ~/dots
git add .
sudo nix flake update --flake ~/dots $impure
git add .
sudo nixos-rebuild switch --flake ~/dots#nixos-btw $impure
git add .
echo "Commit Message: "
read -r commitMessage
git commit -m "$commitMessage"
git push
