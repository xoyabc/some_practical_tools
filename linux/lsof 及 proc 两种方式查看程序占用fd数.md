```shell
lsof -p 28631 |awk --re-interval '$4~/[0-9]{1,}(u|w|r)/' |wc -l && ls /proc/28631/fd  |wc -l
42381
42381
```

/proc/28631/fd
fd下的每个以数字命名的文件表示进程对应的文件描述符

lsof 输出结果中的第五列 **FD** 为文件描述符，应用程序通过文件描述符识别该文件。如cwd、txt等

fd 对应 lsof 的 u/w/r 三种类型的句柄总数

FD 表示进程打开文件描述符：

各值及其含义

```
cwd  current working directory;
Lnn  library references (AIX);
err  FD information error (see NAME column);
jld  jail directory (FreeBSD);
ltx  shared library text (code and data);
Mxx  hex memory-mapped type number xx.
m86  DOS Merge mapped file;
mem  memory-mapped file;
mmap memory-mapped device;
pd   parent directory;
rtd  root directory;
tr   kernel trace file (OpenBSD);
txt  program text (code and data);
v86  VP/ix mapped file;
```


FD is followed by one of these characters, describing the mode under which the file is open:

r for read access;

w for write access;

u for read and write access;

space if mode unknown and no lock character follows;

'-' if mode unknown and lock character follows.
