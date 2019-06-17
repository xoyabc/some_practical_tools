
## 内存

./php.ini:393:memory_limit = 128M

## 进程数及pm模式

REF：https://blog.csdn.net/zeng89/article/details/80299324

    ./php-fpm.conf:219:pm = dynamic

    ./php-fpm.conf:235:pm.start_servers = 20

    ./php-fpm.conf:240:pm.min_spare_servers = 10

    ./php-fpm.conf:245:pm.max_spare_servers = 30

    ./php-fpm.conf:256:;pm.max_requests = 500

```bash
sed -i '/memory_limit/s/384/128/g' /usr/local/php/etc/php.ini

sed -ri '/pm = /s/(.*) = (.*)/\1 = dynamic/g' /usr/local/php/etc/php-fpm.conf  

sed -ri '/pm.start_servers/s/(.*) = (.*)/\1 = 20/g' /usr/local/php/etc/php-fpm.conf

sed -ri '/pm.min_spare_servers/s/(.*) = (.*)/\1 = 10/g' /usr/local/php/etc/php-fpm.conf

sed -ri '/pm.max_spare_servers/s/(.*) = (.*)/\1 = 30/g' /usr/local/php/etc/php-fpm.conf

sed -ri '/pm.max_requests/s/(.*) = (.*)/\1 = 500/g' /usr/local/php/etc/php-fpm.conf   
```
