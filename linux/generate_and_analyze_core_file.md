## generate core file

use `gcore pid` command

you can install the gdb package to make the gcore command available.

```bash
[root@host tmp]# gcore 19765
[Thread debugging using libthread_db enabled]
warning: no loadable sections found in added symbol-file system-supplied DSO at 0xb76f3000
0xb76f3e79 in ?? ()
Saved corefile core.19765
```


## analyze core file

- 1. gdb path_to_executive program path_to_core_file

`gdb /usr/local/nginx/sbin/nginx core.19765`

- 2. press 'bt' and `enter`


```bash
[root@host ~]# cd /tmp/
[root@host tmp]# gdb /usr/local/nginx/sbin/nginx core.19765
GNU gdb (GDB) Red Hat Enterprise Linux (7.2-92.el6)
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-redhat-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/local/nginx/sbin/nginx...(no debugging symbols found)...done.
[New Thread 19765]
Reading symbols from /usr/local/lib/libjemalloc.so.2...done.
Loaded symbols for /usr/local/lib/libjemalloc.so.2
Reading symbols from /lib/libcrypt.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/libcrypt.so.1
Reading symbols from /lib/libz.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/libz.so.1
Reading symbols from /lib/libc.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/librt.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/librt.so.1
Reading symbols from /lib/libpthread.so.0...(no debugging symbols found)...done.
[Thread debugging using libthread_db enabled]
Loaded symbols for /lib/libpthread.so.0
Reading symbols from /lib/libdl.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/libdl.so.2
Reading symbols from /lib/libm.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /lib/ld-linux.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /lib/libfreebl3.so...(no debugging symbols found)...done.
Loaded symbols for /lib/libfreebl3.so
Reading symbols from /lib/libnss_files.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/libnss_files.so.2
Reading symbols from /lib/libnss_dns.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/libnss_dns.so.2
Reading symbols from /lib/libresolv.so.2...(no debugging symbols found)...done.
Loaded symbols for /lib/libresolv.so.2

warning: no loadable sections found in added symbol-file system-supplied DSO at 0xb76f3000
Core was generated by `nginx: master process /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx'.
#0  0xb76f3e79 in ?? ()
Missing separate debuginfos, use: debuginfo-install glibc-2.12-1.209.el6_9.2.i686 nss-softokn-freebl-3.14.3-23.el6_7.i686 zlib-1.2.3-29.el6.i686
(gdb) 
(gdb) 
(gdb) bt
#0  0xb76f3e79 in ?? ()
#1  0x080a6447 in ngx_master_process_cycle ()
#2  0x08082ebd in main ()
(gdb) 
```
