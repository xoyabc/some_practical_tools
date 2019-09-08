

login-path是MySQL5.6开始支持的新特性。通过借助mysql_config_editor工具将登陆MySQL服务的认证信息加密保存在.mylogin.cnf文件（默认位于用户主目录） 。之后，MySQL客户端工具可通过读取该加密文件连接MySQL，避免重复输入登录信息，避免敏感信息暴露。

mysql_config_editor set --login-path=mps --user=cms --host=10.90.34.64 --port=3306 --password


其中可配置项


-h,–host=name 添加host到登陆文件中

-G，–login-path=name 在登录文件中为login path添加名字（默认为client）

-p,–password 在登陆文件中添加密码（该密码会被mysql_config_editor自动加密）

-u，–user 添加用户名到登陆文件中

-S,–socket=name 添加sock文件路径到登陆文件中

-P，–port=name 添加登陆端口到登陆文件中

## 显示配置：

mysql_config_editor print --login-path=test #显示执行的login-path配置

mysql_config_editor print --all #显示所有的login-path信息


## 删除配置：

mysql_config_editor remove --login-path=test

其中可删除项

-h,–host=name 添加host到登陆文件中

-G，–login-path=name 在登录文件中为login path添加名字（默认为client）

-p,–password 在登陆文件中添加密码（该密码会被mysql_config_editor自动加密）

-u，–user 添加用户名到登陆文件中

-S,–socket=name 添加sock文件路径到登陆文件中

-P，–port=name 添加登陆端口到登陆文件中


## 重置配置:


mysql_config_editor reset --login-path=test

使用login-path登录：

shell>mysql --login-path=test

若要登录其他主机、其他端口，或者添加其他额外参数，直接在上述命令后添加即可

shell>mysql --login-path=test -h host1 -P port1 #登录host1:poet1上的MySQL

shell>mysql --login-path=test -h host1 -P port1 test_db #登录host1:poet1上的MySQL中的test_db库
