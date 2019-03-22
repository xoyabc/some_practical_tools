
We recommend using one of the following commands to get the unwrapped output from the "df" command:

```shell
df -lk | awk '{if(/^[^ ]+$/){remember=$0}else{print remember $0}}'
df -Pk
```


## REF

https://support.symantec.com/en_US/article.HOWTO5953.html
