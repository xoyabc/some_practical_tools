## 将系统涉及的环境变量都添加到cron的默认环境变量中

可以避免每次都在脚本中引入环境变量或使用source初始化

如CentOS,可以在`/var/spool/cron/root`中或使用`crontab -e`命令添加所有使用到的环境变量
``` bash
PATH=/usr/local/nginx/sbin:/usr/local/php/bin:/usr/local/apache/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
```
Ubuntu and Debian 系统可以在/etc/crontab中声明环境变量

```
PATH=/usr/local/nginx/sbin:/usr/local/php/bin:/usr/local/apache/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
```


## 脚本第一行要以`#!`(Sha-Bang)开头并跟上对应的解释器路径

不解释~~

Sha-Bang(#!)所在行的作用是告知该脚本使用的是哪种命令解释器

PS，当然也可以在cron中使用`SHELL=/bin/bash`声明shell的解释器,也可以使用`0 5 * * * . $HOME/.profile; /path/to/command/to/run`先载入环境变量再执行。

## 脚本要加执行权限

这个是最基本的了

## 结合日志分析

如果还是未找到原因，可追加日志，之后进一步分析

示例：
``` bash
59 11 * * * /bin/bash /scripts/get_douban_hot_movie.sh >> /root/mylog.log 2>&1
```
## 错误分析

### cron error: bad username

该错误提示为/etc/crontab中指定了不存在的用户，本例中为ubuntu，实际该用户并不存在。

![crontab_1.png](https://i.loli.net/2018/08/28/5b8420ddc0988.png)
![crontab_2.png](https://i.loli.net/2018/08/28/5b8420ddb844b.png)
![crontab_3.png](https://i.loli.net/2018/08/28/5b8420ddacc8c.png)

## 参考

[where-can-i-set-environment-variables-that-crontab-will-use](https://stackoverflow.com/questions/2229825/where-can-i-set-environment-variables-that-crontab-will-use)

[crontab.5.html](http://manpages.ubuntu.com/manpages/xenial/en/man5/crontab.5.html)

[how-can-i-run-a-cron-command-with-existing-environmental-variables](https://unix.stackexchange.com/questions/27289/how-can-i-run-a-cron-command-with-existing-environmental-variables)

