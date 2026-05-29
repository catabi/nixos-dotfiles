#!/bin/sh
set -e
while true; do
  read -p "Mount or Unmount? m/u: " mount
  case $mount in
  [Mm]*)
    mount="mount"
    break
    ;;
  [Uu]*)
    mount="unmount"
    break
    ;;
  *) echo "Answer m to Mount and u to Unmount " ;;
  esac
done
while true; do
  read -p "Use sudo? y/n: " usesudo
  case $usesudo in
  [Yy]*)
    usesudo="sudo"
    break
    ;;
  [Nn]*)
    usesudo=""
    break
    ;;
  *) echo "Answer with y or n" ;;
  esac
done
lsblk
read -p "Choose Device ( /dev/drive ): " device

$usesudo udisksctl $mount -b $device
