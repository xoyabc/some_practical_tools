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
 cat result |grep "Product Name"  |awk -F '[.]' '{print $(NF-1),$NF}'
 esxcli hardware platform get |grep 'Product Name'|awk -F '[:]' '{print $NF}'
 ```
 ### 机器序列号
 ```
 esxcfg-info |grep "Serial Number" |awk -F '[.]' '{print $NF}'
 esxcli hardware platform get |grep 'Serial Number'|awk -F '[:]' '{print $NF}'
 ```
 ### 虚拟机列表-主机名： 
 ```
 esxcli vm process  list |grep 'Display Name'
 vim-cmd vmsvc/getallvms
 ```
 ## 虚拟机列表-IP 
 
 ``` bash
1. Connect to your host via SSH

2. Establish your VM ID

[root@esxi:~] vim-cmd vmsvc/getallvms

3. Now to find out the VMs IP address run:

[root@esxi:~] vim-cmd vmsvc/get.guest 13 | grep ipAddress

OUTPUT:
   ipAddress = "10.10.1.109", 
         ipAddress = (string) [
            ipAddress = (vim.net.IpConfigInfo.IpAddress) [
                  ipAddress = "10.10.1.109", 
                  ipAddress = "fe80::20c:29ff:fec8:db22", 
            ipAddress = (string) [
                     ipAddress = "10.10.1.254", 
                     ipAddress = , 
                     ipAddress = , 
                     ipAddress = "fe80::221:55ff:fefb:da4", 
                     ipAddress = ,
 
 
 或
 vim-cmd vmsvc/get.summary 17(vmid)
 ```

 ### 虚拟机内存
 
 ``` bash
 vim-cmd vmsvc/get.summary 17
 或
 单位G，其中10为vmid,可通过vim-cmd vmsvc/getallvms查看
 vim-cmd vmsvc/device.getdevices 10 |grep memoryMB |awk -F '[, ]' '{printf"%d",$(NF-2)/1024 }'
 ```
 
 ### 虚拟机硬盘
 单位G
 ``` bash
 单位G，其中10为vmid,可通过vim-cmd vmsvc/getallvms查看
 vim-cmd vmsvc/device.getdevices 10 |grep capacityInKB |awk -F '[, ]' '{sum+=$(NF-2)}END{printf"%d",sum/1024/1024 }'
 ```
 
 ### 虚拟机CPU核数
 ```
 vim-cmd vmsvc/get.summary 10 |grep numCpu |awk -F '[, ]' '{print $(NF-2)}'
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
 
 ### 硬盘
 
 单位T
 
 ```
 df  |awk 'NR>1{sum+=$2}END{printf "%0.2f\n",sum/1024/1024/1024/1024}'
 esxcli storage core  device list |awk -F '[: ]' '/Size/&&$NF!~/^0/{printf "%0.2f",$NF/1024/1024}'
 ```
 

### 参考

[finding-hardware-information-using-esxcli](http://masteringvmware.com/esxi-commands-part-2-finding-hardware-information-using-esxcli/)

[esxcli hardware Commands](https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_hardware.html)

[esxi-how-to-find-out-vms-ip-address-from-ssh]( https://nocsma.wordpress.com/2016/10/21/esxi-how-to-find-out-vms-ip-address-from-ssh/)

[How to get hardware report of a esxi host](https://communities.vmware.com/thread/459814)

[find-the-service-tag-or-serial-number-of-vmware-esx-host](http://www.virtualizetips.com/2010/05/24/find-the-service-tag-or-serial-number-of-vmware-esx-host/)

[networking-commands-for-the-vmware-esxi-host-command-line](https://www.tunnelsup.com/networking-commands-for-the-vmware-esxi-host-command-line/)

[Identifying disks when working with VMware ESXi/ESX](https://kb.vmware.com/s/article/1014953)

[a-list-of-esxcli-storage-commands-you-cant-live-without](https://cormachogan.com/2014/02/25/a-list-of-esxcli-storage-commands-you-cant-live-without/)

[The-top-25-ESX-commands-and-ESXi-commands](https://searchservervirtualization.techtarget.com/tip/The-top-25-ESX-commands-and-ESXi-commands)

[get-vmid-via-pyvmomi](https://stackoverflow.com/questions/33717752/get-vmid-via-pyvmomi)

[获取虚拟机机器信息](http://esx-guy.blogspot.com/2012/03/how-to-query-virtual-machine-from.html)

[VMWareCLI命令参考(很详细)](http://xstarcd.github.io/wiki/Cloud/VMWareCLI.html)

