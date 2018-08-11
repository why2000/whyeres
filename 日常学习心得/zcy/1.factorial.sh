#!/bin/bash
# accept a num as an attr and print its factorial
# author: mani

function factorial(){ # common algorithm
    local n=$1 # it should be noticed that global variables are deafault inside a function  
    if [ $n == 0 ]
    then
        #return 1 #this causes error when n >= 7
        newReturn=1
    else
        factorial `expr $n - 1 `
        #return `expr $n \* $? `
        newReturn=`expr $n \* $newReturn `
        #newReturn=`./a.out $n $newReturn`
        # expr has a upper bound, it give an error when n >= 21
        # I suppose it's due to the data type
        # maybe I should use python to calculate :(
    fi

    return $newReturn
}

if [ ! $1 ] # no attr input
then
    echo "Usage: ./1.factorial.sh [num]"
    echo "accept a num as an attr and print its factorial"
elif [ "$1" -gt 0 ] 2>/dev/null # attr is not a num; ignore error
then 
    factorial $1
    echo $newReturn
else
    echo "positive integer required"
fi
