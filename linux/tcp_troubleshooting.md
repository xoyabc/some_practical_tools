
 - tcp_tw_recycle参数开启会导致部分NAT网关出来的用户访问失败

[NAT网络下TCP连接建立时可能SYN包被服务器忽略-tcp_tw_recycle](https://blog.csdn.net/rainharder/article/details/46775601)

[tcp_tw_recycle参数引发的故障](https://blog.csdn.net/wireless_tech/article/details/6405755)

```
我们在一些高并发的 WebServer上，为了端口能够快速回收，打开了 tcp_tw_reccycle ，而在关闭 tcp_tw_reccycle 的
时候，kernal 是不会检查对端机器的包的时间戳的；打开了 tcp_tw_reccycle 了，就会检查时间戳，很不幸移动的cmwap
发来的包的时间戳是乱跳的，所以我方的就把带了“倒退”的时间戳的包当作是“recycle的tw连接的重传数据，不是新的请
求”，于是丢掉不回包，造成大量丢包。
```

- tcp 标志位 与 三次握手/四次挥手

https://blog.csdn.net/taoqilin/article/details/79516254

https://blog.csdn.net/wuanwujie/article/details/71439551

```
SYN(synchronous建立联机) 

ACK(acknowledgement 确认) 

PSH(push传送) 

FIN(finish结束) 

RST(reset重置) 

URG(urgent紧急)
```
