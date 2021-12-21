#!/bin/bash


cat hostname |awk 'NR%10!=0 && NR%10!=1{printf "\047%s\047,", $1;}NR%10==0{printf "\047%s\047,\n", $1;}' |sed '$s/,$//' ;echo

#cat hostname |while read line
#do
#       echo -n "'"
#       echo -n "${line}"
#       echo -n "'"
#       echo -n ","
#done
#echo -e "\n"
