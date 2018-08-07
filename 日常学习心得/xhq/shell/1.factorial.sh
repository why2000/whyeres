#!/bin/bash
if [ -z $1 ];
    then  echo "usage : 1.factorial.sh [n]"
          echo "calculates the factorial of a number"
          exit 1
fi
result=1
counter=$1
function fac(){
  if [ $counter -eq 1 ];
    then
      echo $result
    else  
      let result*=$counter
      let counter--
      fac
  fi
}
fac