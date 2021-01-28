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

group_num=5000
total_num=$(cat ${FILE} |wc -l)

awk -v t_num="${total_num}" -v g_num="${group_num}" '
{ if((NR%g_num==1 && NR==t_num) || g_num==1)
      printf "INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES (\047%s\047, \0470\047);\n", $1;
  else {
      if (NR%g_num==1)
          printf "INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES (\047%s\047, \0470\047),\n", $1;
      else if ((NR%g_num!=0 && NR%g_num!=1) && NR!=t_num)
          printf "(\047%s\047, \0470\047),\n", $1;
      else if ((NR%g_num==0) || NR==t_num)
          printf "(\047%s\047, \0470\047);\n", $1;
     }
}' ${FILE} > ${SQL_FILE}
