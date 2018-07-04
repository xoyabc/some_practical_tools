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

### 参考

[finding-hardware-information-using-esxcli](http://masteringvmware.com/esxi-commands-part-2-finding-hardware-information-using-esxcli/)

[esxcli hardware Commands](https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_hardware.html)

[How to get hardware report of a esxi host](https://communities.vmware.com/thread/459814)

[find-the-service-tag-or-serial-number-of-vmware-esx-host](http://www.virtualizetips.com/2010/05/24/find-the-service-tag-or-serial-number-of-vmware-esx-host/)

