```shell
lsof -p 28631 |awk --re-interval '$4~/[0-9]{1,}(u|w|r)/' |wc -l && ls /proc/28631/fd  |wc -l
42381
42381
```

fd 对应 lsof 的 u/w/r 三种类型的句柄总数
