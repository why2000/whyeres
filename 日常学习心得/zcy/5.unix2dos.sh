#!/bin/bash
# dos2unix and unix2dos
# author: mani
 
if [ ! $1 ] # no attr input
then # use printf to format
    printf "\033[1;31;40m%-4s\033[0m\n" "do not rename us thanks :)"
    printf "%-6s %s\n" Usage: "./5.dos2unix.sh [filename]"
    printf "%-10s %s\n" "" "convert dos to unix"
    printf "%-6s %s\n" "" "./5.unix2dos.sh [filename]"
    printf "%-10s %s\n" "" "convert unix to dos"
else
    case $0 in
    "./5.dos2unix.sh")
        echo "dos2unix done"
        sed 's/.$//' $1 > 5.temp
    ;;
    "./5.unix2dos.sh")
        echo "unix2dos done"
        sed 's/$/\r/' $1 > 5.temp
    ;;
    esac
    rm -f $1
    mv 5.temp $1
fi