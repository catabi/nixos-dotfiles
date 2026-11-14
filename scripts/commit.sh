#!/bin/sh
set -e
git add .
read -p "Commit Message: " commitMessage
if [ "$commitMessage" = "" ]; then
  commitMessage="meowing (goober didn't put a message)"
fi
git commit -m "$commitMessage"
git push
