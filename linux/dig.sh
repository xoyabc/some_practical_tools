#!/bin/bash

domain=(
www.baidu.com
www.sohu.com
)

for i in ${domain[@]}
do
        echo -n "${i} "
        #dig ${i} +short CNAME @114.114.114.114
        A_Record=$(dig ${i} +short A @114.114.114.114 |tr '\n' ' ')
        echo "${A_Record}"
done
