
## 三次握手示意图

![TCP三次握手 (1).png](https://i.loli.net/2018/12/31/5c28fef7906f0.png)

## 极客漫画：TCP 兄弟

![tcp-buddies.jpg](https://i.loli.net/2018/12/31/5c29072f58347.jpg)

这幅漫画展示了 TCP 协议的沟通过程。首先是构建一个层（TCP 工作于传输层），然后向要通信的人发送建立联系的信号（SYN），接受到信息的人回复确认信息（ACK），确认已经收到，同时，发送建立联系的信息（SYN），这时，它发送的信息就是（SYN-ACK），当最初发送信息的人收到信息后，再回复了确认信息（ACK）。在回复了确认信息后，他们可以正常的交流，就开始说话了。

TCP 协议规定，在传输数据之前，要进行三次“握手”，来保证数据传输的可靠性。上面这幅漫画就展示了这样的内容。


## TCP三次握手/四次挥手 及 状态变迁图

https://blog.csdn.net/pmt123456/article/details/56677578

## TCP 连接状态图

[TCP connection status](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.halu101/constatus.htm)
