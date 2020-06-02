REF: [Linux 找出最有可能被 OOM Killer 杀掉的进程](https://github.com/Yhzhtk/note/issues/31)

OOM killer 是什么意思，可以在网上查一下，很多资料，这里不再解释。

其中有三个相关文件：

* /proc/$PID/oom_adj
* /proc/$PID/oom_score
* /proc/$PID/oom_score_adj

其中 oom_score 表示最终的分数，**该分数越大，越可能被 Killer 杀掉。**

而 oom_adj 是调整分数的，可以设置为负值，会对 oom_score减分。

从Linux 2.6.36开始都安装了/proc/$PID/oom_score_adj，此后将替换为/proc/$PID/oom_adj。详细内容请参考Documentation/feature-removal-schedules.txt。即使当前是对/proc/$PID/oom_adj进行的设置，在内核内部进行变换后的值也是针对/proc/$PID/oom_score_adj设置的。

通过 cat /proc/$PID/oom_score 可以查看进程的得分，下面的脚步是可以查询系统**所有进程**的 oom_score。

```
ps -eo pid,comm,pmem --sort -rss | awk '{"cat /proc/"$1"/oom_score" | getline oom; print $0"\t"oom}'
```

上面的命令会得到如下结果：

```
  PID COMMAND         %MEM
28810 java            36.1      178
 4648 java            22.7      124
14489 java            18.3      119
30511 java            11.7      91
14135 salt-minion      0.2      1
29424 rsyslogd         0.1      1
23480 pickup           0.0      1
 1343 qagent           0.0      1
 5586 sshd             0.0      1
22999 collectd         0.0      1
```

其中第一列是PID，第二列是进程，第三列表示内存使用百分比，最后一列即为 oom_score。

最容易被杀掉的是 28810 这个 java 程序，因为分数最高。

