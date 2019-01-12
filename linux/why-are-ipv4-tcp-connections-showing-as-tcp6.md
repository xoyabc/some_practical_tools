## Question 1

Why do the last three connections show as tcp6 even though they're IPv4 addresses?

Here's the output of netsat -tupn on my Debian Jessie server:

```shell
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 10.0.0.12:445           10.0.0.20:49729         ESTABLISHED 26277/smbd      
tcp        0      0 10.0.0.12:443           10.0.0.21:44162         ESTABLISHED 1400/nginx: worker 
tcp        0      0 10.0.0.12:445           10.0.0.21:46650         ESTABLISHED 23039/smbd      
tcp        0      0 10.0.0.12:443           10.0.0.20:54584         ESTABLISHED 1400/nginx: worker 
tcp        0      0 10.0.0.12:139           10.0.0.225:10425        ESTABLISHED 23701/smbd      
tcp        0      0 10.0.0.12:445           10.0.0.217:49179        ESTABLISHED 21535/smbd      
tcp        0      0 10.0.0.12:445           10.0.0.217:49178        ESTABLISHED 21534/smbd      
tcp        0      0 10.0.0.12:445           10.0.0.20:64636         ESTABLISHED 21470/smbd      
tcp        0      0 10.0.0.12:443           10.0.0.21:44198         ESTABLISHED 1400/nginx: worker 
tcp        0      0 10.0.0.12:2049          10.0.0.16:752           ESTABLISHED -               
tcp        0      0 10.0.0.12:222           10.0.0.21:55514         ESTABLISHED 23111/sshd: redacted
tcp6       0      0 10.0.0.12:4243          10.0.0.20:64702         ESTABLISHED 31307/java      
tcp6       0      0 10.0.0.12:48932         162.222.40.93:443       ESTABLISHED 31307/java      
tcp6       0      0 10.0.0.12:49093         216.17.8.47:443         ESTABLISHED 31307/java 
```

## Answer 1:

This is happening because by default, AF_INET6 sockets will actually work for both IPv4 and IPv6. 

## Question 2:

I have a computer with:

Linux superhost 3.2.0-4-amd64 #1 SMP Debian 3.2.60-1+deb7u3 x86_64 GNU/Linux
It runs Apache on port 80 on all interfaces, and it does not show up in netstat -planA inet, however it unexpectedly can be found in netstat -planA inet6:

```shell
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::5672                 :::*                    LISTEN      2402/beam.smp   
tcp6       0      0 :::111                  :::*                    LISTEN      1825/rpcbind    
tcp6       0      0 :::9200                 :::*                    LISTEN      2235/java       
tcp6       0      0 :::80                   :::*                    LISTEN      2533/apache2    
tcp6       0      0 :::34611                :::*                    LISTEN      1856/rpc.statd  
tcp6       0      0 :::9300                 :::*                    LISTEN      2235/java       
...
tcp6       0      0 10.0.176.93:80          10.0.76.98:53704        TIME_WAIT   -               
tcp6       0      0 10.0.176.93:80          10.0.76.98:53700        TIME_WAIT   -      
```
I can reach it by TCP4 just fine, as seen above. However, even these connections are listed under tcp6. Why?

## Answer 2-1:

By default if you don't specify address to Apache Listen parameter, it handles ipv6 address using IPv4-mapped IPv6 
addresses. You can take a look in Apache ipv6

The output of netstat doesn't mean Apache is not listening on IPv4 address. It's a IPv4-mapped IPv6 address.


## Answer 2-2:

```shell
The reason for this is because all IPv4 addresses are also IPv6 addresses. A small range of IPv6 addresses
was set aside to be used for one-to-one mapping of IPv4 addresses.For example, the IPv4 address 192.0.2.128
is accessible via the IPv6 address ::ffff:192.0.2.128. This was done so that any applications which support
IPv6 only, could still listen on IPv4 addresses. Note that this can't be used for an IPv6 address (non-mapped)
to talk to an IPv4 address without other things involved, as the IPv4 won't know how to handle the IPv6 address
(you can use NAT, or other solutions though).

Since all IPv4 addresses are represented in IPv6, when asking netstat to list apps using IPv6, you're also going
to get IPv4.It could represent 10.0.176.93 as ::ffff:10.0.176.93, or even ::ffff:a00:b05d, but the application 
developers chose to show it as a regular dotted-notation IPv4 address.
```


REF:

[why-are-ipv4-tcp-connections-showing-as-tcp6](https://unix.stackexchange.com/questions/237731/why-are-ipv4-tcp-connections-showing-as-tcp6)

[netstat-why-are-ipv4-daemons-listening-to-ports-listed-only-in-a-inet6](https://unix.stackexchange.com/questions/152612/netstat-why-are-ipv4-daemons-listening-to-ports-listed-only-in-a-inet6)

[IPv4-mapped IPv6 addresses](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.hale001/ipv6d0031001726.htm)

[Apache ipv6](http://httpd.apache.org/docs/2.0/bind.html#ipv6)
