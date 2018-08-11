#!/bin/bash
# display filenames sorted by size in specific folder 
# author: mani

d="./"
n=""
m=`pwd`

if [ ! $1  ] # no attr input
then 
    ls -Slh | grep -v total | awk '{ printf "\033[1;32;40m%-4s\033[0m \033[1;31;40m%-4s\033[0m %s\n",FNR,$5,$9 }'
    echo "use --help to see more"
elif [ $1 == "--help" ]
then
    printf "%-6s %s\n" Usage: "-d [directory path]"
    printf "%-10s %s\n" "" "select specific path, ./ as default"
    printf "%-6s %s\n" "" "-n [number]"
    printf "%-10s %s\n" "" "num of files displayed, all as default"
else
    i=()
    j=0
    for k in "$@"; do
        i[$j]=$k
        let j++
    done
    len=${#i[*]}
    #echo $len
    #echo ${i[*]}
    #echo `expr $len - 1`
    for((l=0;l<=`expr $len - 1`;l++));do
        attr=${i[l]}
        #echo "attr is $attr";
        case $attr in
        "-d") d=${i[`expr $l + 1`]}
        ;;
        "-n") n=${i[`expr $l + 1`]}
        ;;
        esac
    done

    cd $d
    if [ $n ]
    then ls -Slh | grep -v total | awk '{ printf "\033[1;32;40m%-4s\033[0m \033[1;31;40m%-4s\033[0m %s\n",FNR,$5,$9 }' | head -$n
    else ls -Slh | grep -v total | awk '{ printf "\033[1;32;40m%-4s\033[0m \033[1;31;40m%-4s\033[0m %s\n",FNR,$5,$9 }'
    fi
    cd $m

fi