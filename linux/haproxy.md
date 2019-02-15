## ubuntu 

### 版本
```
$haproxy -v
HA-Proxy version 1.7.11-1ppa1~trusty 2018/04/30
Copyright 2000-2018 Willy Tarreau <willy@haproxy.org>
```

### 配置

```
global
        log 127.0.0.1   local0 info
        log 127.0.0.1   local1 notice
        #log /dev/log   local0
        #log /dev/log   local1 notice
        maxconn 200000
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        #crt-base /etc/ssl/private
        crt-base /data/ssl
        tune.maxrewrite 81920
        tune.bufsize    163840
        tune.ssl.default-dh-param 2048

        # Default ciphers to use on SSL-enabled listening sockets.
        # For more information, see ciphers(1SSL). This list is from:
        #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
        # An alternative list with additional directives can be obtained from
        #  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
        ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
        ssl-default-bind-options no-sslv3

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        option  redispatch
        option  abortonclose
#       option forwardfor
        retries 3
#       redispatch
        maxconn 100000
        timeout connect 10000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

listen status
        bind *:8887
        mode http
        log global
        acl local_host src 192.168.40.0/24
        stats refresh 15s
        stats uri /haproxy-status
        stats realm haproxy
        stats auth jan:123456
        stats admin if local_host

frontend http_80
        bind *:80
        mode http
        log global
        option forwardfor
        capture request header Host len 32
        http-request del-header If-None-Match

        acl test hdr_reg(host) -i (testa|testb).quanshi.com

        use_backend test_a_nodes if test

#frontend http_443 
#        bind *:443 ssl crt quanshi.pem crt qsh1.cn.pem
#        mode http
#        option forwardfor
#        capture request header Host len 32
#        http-request del-header If-None-Match
#
#        acl test hdr_reg(host) -i (testa|testb).quanshi.com
#
#        use_backend test_a_nodes if test


backend test_a_nodes
        server test_a_1 172.20.30.138:8080 weight 1 maxconn 10000 check inter 5000 rise 2 fall 5
        server test_a_2 172.20.30.139:8080 weight 1 maxconn 10000 check inter 5000 rise 2 fall 5
```

### 日志打印配置

```
$cat /etc/rsyslog.d/49-haproxy.conf 
# Create an additional socket in haproxy's chroot in order to allow logging via
# /dev/log to chroot'ed HAProxy processes
$AddUnixListenSocket /var/lib/haproxy/dev/log

# Send HAProxy messages to a dedicated logfile
if $programname startswith 'haproxy' then /var/log/haproxy.log
&~
```

```
$cat /etc/rsyslog.conf  |grep -v ^# |sed  '/^$/d'
$ModLoad imuxsock # provides support for local system logging
$ModLoad imklog   # provides kernel logging support
$ModLoad imudp
$UDPServerRun 514
$AllowedSender UDP, 127.0.0.1
$KLogPermitNonKernelFacility on
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat
$RepeatedMsgReduction on
$FileOwner syslog
$FileGroup adm
$FileCreateMode 0640
$DirCreateMode 0755
$Umask 0022
$PrivDropToUser syslog
$PrivDropToGroup syslog
$WorkDirectory /var/spool/rsyslog
$IncludeConfig /etc/rsyslog.d/*.conf
```

### 日志切割配置

```
$cat /etc/logrotate.d/haproxy 
/var/log/haproxy.log {
    daily
    rotate 52
    missingok
    notifempty
    compress
    delaycompress
    su root list
    create 777 syslog adm
    postrotate
        /etc/init.d/rsyslog restart >/dev/null 2>&1 || true
    endscript
}
```

