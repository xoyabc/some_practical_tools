#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: bash $0 filename"
    exit 0
fi
# billingcode/passcode/temporary conference id
FILE="$1"
# insert sql file 
SQL_FILE="insert_$(date +%Y%m%d).sql"
> ${SQL_FILE}

group_num=10000
total_num=$(cat ${FILE} |wc -l)

for i in $(seq 1 ${group_num} ${total_num})
do
    first_line_num=${i}
    let last_line_num=${i}+${group_num}-1
    if [ ${last_line_num} -gt ${total_num} ]
    then
        last_line_num=${total_num}
    fi
    #echo ${first_line_num} ${last_line_num}
    # print insert statement when the num of group is 1 
    if [ ${first_line_num} -eq ${last_line_num} ]
    then
        awk -v f_num="${first_line_num}" -v l_num="${last_line_num}" 'NR==f_num{
            printf "INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES (\047%s\047, \0470\047);\n", $1
           }' ${FILE} >> ${SQL_FILE}
    else
        # print insert statement when the num of group is more than 1
        awk -v f_num="${first_line_num}" -v l_num="${last_line_num}" 'NR==f_num{
            printf "INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES (\047%s\047, \0470\047),\n", $1
           }' ${FILE} >> ${SQL_FILE}
        awk -v f_num="${first_line_num}" -v l_num="${last_line_num}" 'NR>f_num&&NR<l_num{
            printf "(\047%s\047, \0470\047),\n", $1
           }' ${FILE} >> ${SQL_FILE}
        awk -v f_num="${first_line_num}" -v l_num="${last_line_num}" 'NR==l_num{
            printf "(\047%s\047, \0470\047);\n", $1
           }' ${FILE} >> ${SQL_FILE}
    fi
done
