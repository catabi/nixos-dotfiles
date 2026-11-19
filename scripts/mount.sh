#!/bin/sh
set -e
if [[ -n $1 ]]; then
  device=$1
  usesudo=""
  if findmnt -rno TARGET "/dev/$device"; then
    mount="unmount"
  else
    mount="mount"
  fi
else
  while true; do
    read -p "Mount or Unmount? M/u: " mount
    case $mount in
    [Mm]*)
      mount="mount"
      break
      ;;
    [Uu]*)
      mount="unmount"
      break
      ;;
    "")
      mount="mount"
      break
      ;;
    *) echo "Answer m to Mount and u to Unmount " ;;
    esac
  done
  while true; do
    read -p "Use sudo? y/N: " usesudo
    case $usesudo in
    [Yy]*)
      usesudo="sudo"
      break
      ;;
    [Nn]*)
      usesudo=""
      break
      ;;
    "")
      usesudo="sudo"
      break
      ;;
    *) echo "Answer with y or n" ;;
    esac
  done
  lsblk
  read -p "Choose Device: " device
fi
$usesudo udisksctl "$mount" -b "/dev/$device"
