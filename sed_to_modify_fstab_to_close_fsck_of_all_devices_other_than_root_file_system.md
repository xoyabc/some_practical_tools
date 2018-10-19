The space- or tab-separated fields within each row (typically aligned in columns, as above, but this is not a requirement) must appear in a specific order, as follows:

*device-spec* – The device name, label, UUID, or other means of specifying the partition or data source this entry refers to.
*mount-point* – Where the contents of the device may be accessed after mounting; for swap partitions or files, this is set to none.
*fs-type* – The type of file system to be mounted.
*options* – Options describing various other aspects of the file system, such as whether it is automatically mounted at boot, which users may mount or access it, whether it may be written to or only read from, its size, and so forth; the special option defaults refers to a predetermined set of options depending on the file system type.
*dump* – A number indicating whether and how often the file system should be backed up by the dump program; a zero indicates the file system will never be automatically backed up.
*pass* – A number indicating the order in which the fsck program will check the devices for errors at boot time; this is 1 for the root file system and either 2 (meaning check after root) or 0 (do not check) for all other devices.

因搬迁ESXI宿主机，重启后其下的虚拟机因之前分区的pass值为2，开机时要磁盘自检，过程较慢，需要关闭自检，即将其值设置为0。

```bash
sed -i.bak '/.*\/.*/s/\(2\)\s*$/0/' /etc/fstab 
# 使用扩展正则(--regexp-extended)
# -i参数后使用".bak"，替换前先备份原文件，备份文件名为原文件名.bak
# /.*\/.*/ 匹配有挂载点的行，防止修改其他注释行
sed -ri.bak '/.*\/.*/s/(2)\s*$/0/' /etc/fstab
sed -ri.bak 's#^(.*)/(.*)(2)(\s*)$#\1/\20\4#g' /etc/fstab
```



