#!/bin/bash

function print() {
    sys=$(uname)
    if [ $sys = "Darwin" ]; then
      ifconfig en0 | grep "inet " | awk '{ print $2}'
    else 
      ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'
    fi
}
function set() {
    sys=$(uname)
    if [ $sys = "Darwin" ]; then
      ifconfig en0 $2 netmask $4
    else 
      ifconfig eth0 $2 netmask $4
    fi
    echo Setup completed.
}
if [ $# == 0 ]; then 
  print
  exit 0
fi
if [ $# == 4 ] && [ "$1" == "-ip" ] && [ "$3" == "-mask" ]; then
  set
else
  echo Usage: ./3.myip.sh [ ]
  echo    or: ./3.myip.sh -ip [IP address] -mask [Mask]
fi