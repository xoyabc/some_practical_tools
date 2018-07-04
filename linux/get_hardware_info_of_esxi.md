### 获取所有配置信息，包括CPU、硬盘、内存、PCI等。
 ``` bash
 esxcfg-info
 ```
 
 ### cpu核数：
 ``` bash
 cat /proc/cpuinfo |wc -l
 esxcli hardware cpu list |grep CPU: |wc -l
 ```
 
 ### 机器型号：
 ``` bash
 cat result |grep "Product Name"  |awk -F "[.]" '{print $(NF-1),$NF}'
 esxcli hardware platform get |grep 'Product Name'|awk -F '[:]' '{print $NF}'
 ```
 ### 机器序列号
 ```
 esxcfg-info |grep "Serial Number" |awk -F "[.]" '{print $NF}'
 esxcli hardware platform get |grep 'Serial Number'|awk -F '[:]' '{print $NF}'
 ```
 ### 虚拟机列表： 
 ```
 esxcli vm process  list |grep 'Display Name'
 ```
 
 ### ESXI版本：
 ``` bash
 esxcli system version get |grep Version |awk '{print $NF}'
 ```
 ### 主机名：
 ``` bash
 esxcli system hostname get |grep 'Host Name' |awk '{print $NF}'
 ```
 ### 内存：
 ``` bash
 esxcli hardware memory get |awk 'NR==1{printf "%0.2f\n",$(NF-1)/1024/1024/1024}'
 ```
