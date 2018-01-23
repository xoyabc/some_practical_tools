#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : 1031138448@qq.com
# * Last modified : 2018-01-24 00:55
# * Filename      : get_available_tracker.sh
# * Description   : get available tracker address and output to valid_tracerk.txt
# * ********************************************************

# define a output function
warn_echo()
{
    echo -e "\033[40;93m[Warning]: $1 \033[0m"
}

info_echo()
{
    echo -e "\033[40;32m[Info]: $1 \033[0m"
}

Usage ()
{
    echo "Usage:sh $0 tracer_file"
    exit 0
}
[ $# -ne 1 ] && Usage
TRACKER_FILE="$1"
AVAILABLE_TRACKER="valid_tracerk.txt"
> ${AVAILABLE_TRACKER}
# check if a port is reachable
function check_port ()
{
 HOST="$1"
 PORT="$2"
 nc -z -v -w 1 ${HOST} ${PORT} &>/dev/null
 result1=$?
 if [ "$result1" != 0 ]
 then
    warn_echo "port ${PORT} is closed"
 else
    info_echo "port ${PORT} is open"
 fi
 
}

cat ${TRACKER_FILE} |while read line
do
    tracker_info=$(echo "${line}" |sed -r 's#([^/]*)//([^/:]*)(:?)([0-9]{0,5})(/?).*$#\2 \4#g')
    host=$(echo "${tracker_info}" |awk '{print $1}')
    port=$(echo "${tracker_info}" |awk '{print $2}')
    [ -z ${port} ] && port=80
    #echo "${host} ${port}"
    if `check_port ${host} ${port} |grep -q open`
    then
        echo ${line} >> ${AVAILABLE_TRACKER}
    else
        continue
    fi
done
