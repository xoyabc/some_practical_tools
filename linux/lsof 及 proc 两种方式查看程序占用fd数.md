```shell
lsof -p 28631 |awk --re-interval '$4~/[0-9]{1,}(u|w|r)/' |wc -l && ls /proc/28631/fd  |wc -l
42381
42381
```
