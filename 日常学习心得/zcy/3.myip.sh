#!/bin/bash
# self-compression according to the filename suffix
# author: mani

interface="eth0"
ip=""
mask=""

if [ ! $1  ] # no attr input
then 
    ifconfig | grep inet | grep -v "inet6\|127" | awk '{print $1 " " $2}'
    ifconfig | grep inet | grep -v "inet6\|127" | awk '{print $4}'
    echo "use --help to see more"
elif [ $1 == "--help" ]
then
    printf "%-6s %s\n" Usage: "--select [interface]"
    printf "%-10s %s\n" "" "select specific interface, eth0 as deafault"
    printf "%-6s %s\n" "" "--ip [ip address]"
    printf "%-10s %s\n" "" "--set new ip"
    printf "%-6s %s\n" "" "--mask [mask address]"
    printf "%-10s %s\n" "" "set new mask"
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
        "--select") interface=${i[`expr $l + 1`]}
        ;;
        "--ip") ip=${i[`expr $l + 1`]}
        ;;
        "--mask") mask=${i[`expr $l + 1`]}
        ;;
        esac
    done

    if [ $ip ]
    then
        ifconfig $interface $ip
        echo "set $interface ip to $ip"
    fi

    if [ $mask ]
    then
        ifconfig $interface netmask $mask
        echo "set $interface mask to $mask"
    fi

fi