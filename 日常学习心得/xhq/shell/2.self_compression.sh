#!/bin/bash
function install() {
    sys=$(uname)
    if [ $sys = "Darwin" ]; then
      brew install p7zip
    else 
      if command -v apt-get >/dev/null 2>&1; then 
        apt-get install p7zip
      elif command -v yum >/dev/null 2>&1; then 
        yum install p7zip
      else 
        echo "You are using a Linux distribution that this script didn't adapted to."
        exit -1
      fi
    fi
      $0
}

function unzip(){
  if [ $# == 1 ]; then
    7za x $1 -r
  else 
    7za x $1 -r -o$2
  fi
}

if [ $# == 0 ]; then
  echo Archive unzipper.
  echo usage: ./2.self_compression list
  echo    or: ./2.self_compression [ArchiveFile]
  echo    or: ./2.self_compression [ArchiveFile] [TargetPath]
  exit 0
fi

if [ $1 = list ]; then
  echo Supportted formats: AR, ARJ, CAB, CHM, CPIO, CramFS, DMG, EXT, FAT, GPT, HFS, IHEX, ISO, LZH, LZMA, MBR, MSI, NSIS, NTFS, QCOW2, RAR, RPM, SquashFS, UDF, UEFI, VDI, VHD, VMDK, WIM, XAR and Z.
  exit 0
fi

if command -v 7za >/dev/null 2>&1; then 
  unzip
else 
  echo "This script needs 7-zip support, do you want to install it ? (y/N)"
  read com
  if [ $com = "y" ]; then
     install
  else exit -1;
  fi
fi