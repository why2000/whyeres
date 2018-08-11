#!/bin/bash
# self-compression according to the filename suffix
# author: mani

if [ ! $1  ] # no attr input
then # use printf to format
    printf "%-6s %s\n" Usage: "--list"
    printf "%-10s %s\n" "" "list supported file type"
    printf "%-6s %s\n" "" "[source compressed file] [output path]"
    printf "%-10s %s\n" "" "self-compression according to the filename suffix"
elif [ $1 == "--list" ]
then
    echo "zip tar tar.gz tar.bz2"
elif [ -f $1 -a -d $2 ]
then
    suffix=${1#*.}
    # lazy match "." from L to R
    # refer to https://blog.csdn.net/xtzmm1215/article/details/52768574
    outputDir=$2
    case $suffix in
        "zip") unzip $1 -d $outputDir
        ;;
        "tar") tar -xvf $1 -C $outputDir
        ;;
        "tar.gz") tar -zxvf $1 -C $outputDir
        ;;
        "tar.bz2") tar -jxvf $1 -C $outputDir
        ;;
        *) echo "unsupported file type"
    esac
else
    echo "invalid attr"
fi

