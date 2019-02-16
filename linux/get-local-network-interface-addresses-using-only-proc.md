## Bash

```shell
awk '/32 host/ { print f } {f=$2}' <<< "$(</proc/net/fib_trie)"
```

```shell
#!/bin/bash

# ip functions that set variables instead of returning to STDOUT

hexToInt() {
    printf -v $1 "%d\n" 0x${2:6:2}${2:4:2}${2:2:2}${2:0:2}
}
intToIp() {
    local var=$1 iIp
    shift
    for iIp ;do 
        printf -v $var "%s %s.%s.%s.%s" "${!var}" $(($iIp>>24)) \
            $(($iIp>>16&255)) $(($iIp>>8&255)) $(($iIp&255))
    done
}
maskLen() {
    local i
    for ((i=0; i<32 && ( 1 & $2 >> (31-i) ) ;i++));do :;done
    printf -v $1 "%d" $i
}

# The main loop.

while read -a rtLine ;do
    if [ ${rtLine[2]} == "00000000" ] && [ ${rtLine[7]} != "00000000" ] ;then
        hexToInt netInt  ${rtLine[1]}
        hexToInt maskInt ${rtLine[7]}
        if [ $((netInt&maskInt)) == $netInt ] ;then
            for procConnList in /proc/net/{tcp,udp} ;do
                while IFS=': \t\n' read -a conLine ;do
                    if [[ ${conLine[1]} =~ ^[0-9a-fA-F]*$ ]] ;then
                        hexToInt ipInt ${conLine[1]}
                        [ $((ipInt&maskInt)) == $netInt ] && break 3
                    fi
                done < $procConnList
            done
        fi
    fi
done < /proc/net/route 

# And finaly the printout of what's found

maskLen maskBits $maskInt
intToIp addrLine $ipInt $netInt $maskInt
printf -v outForm '%-12s: %%s\\n' Interface Address Network Netmask Masklen
printf "$outForm" $rtLine $addrLine $maskBits\ bits
```

## Python


```python
#!/usr/bin/python
from socket import AF_INET, AF_INET6, inet_ntop
from ctypes import (
    Structure, Union, POINTER, 
    pointer, get_errno, cast,
    c_ushort, c_byte, c_void_p, c_char_p, c_uint, c_int, c_uint16, c_uint32
)
import ctypes.util
import ctypes

class struct_sockaddr(Structure):
     _fields_ = [
        ('sa_family', c_ushort),
        ('sa_data', c_byte * 14),]

class struct_sockaddr_in(Structure):
    _fields_ = [
        ('sin_family', c_ushort),
        ('sin_port', c_uint16),
        ('sin_addr', c_byte * 4)]

class struct_sockaddr_in6(Structure):
    _fields_ = [
        ('sin6_family', c_ushort),
        ('sin6_port', c_uint16),
        ('sin6_flowinfo', c_uint32),
        ('sin6_addr', c_byte * 16),
        ('sin6_scope_id', c_uint32)]

class union_ifa_ifu(Union):
    _fields_ = [
        ('ifu_broadaddr', POINTER(struct_sockaddr)),
        ('ifu_dstaddr', POINTER(struct_sockaddr)),]

class struct_ifaddrs(Structure):
    pass

struct_ifaddrs._fields_ = [
    ('ifa_next', POINTER(struct_ifaddrs)),
    ('ifa_name', c_char_p),
    ('ifa_flags', c_uint),
    ('ifa_addr', POINTER(struct_sockaddr)),
    ('ifa_netmask', POINTER(struct_sockaddr)),
    ('ifa_ifu', union_ifa_ifu),
    ('ifa_data', c_void_p),]

libc = ctypes.CDLL(ctypes.util.find_library('c'))

def ifap_iter(ifap):
    ifa = ifap.contents
    while True:
        yield ifa
        if not ifa.ifa_next:
            break
        ifa = ifa.ifa_next.contents

def getfamaddr(sa):
    family = sa.sa_family
    addr = None
    if family == AF_INET:
        sa = cast(pointer(sa), POINTER(struct_sockaddr_in)).contents
        addr = inet_ntop(family, sa.sin_addr)
    elif family == AF_INET6:
        sa = cast(pointer(sa), POINTER(struct_sockaddr_in6)).contents
        addr = inet_ntop(family, sa.sin6_addr)
    return family, addr

class NetworkInterface(object):
    def __init__(self, name):
        self.name = name
        self.index = libc.if_nametoindex(name)
        self.addresses = {}
    def __str__(self):
        return "%s [index=%d, IPv4=%s, IPv6=%s]" % (
            self.name, self.index,
            self.addresses.get(AF_INET),
            self.addresses.get(AF_INET6))

def get_network_interfaces():
    ifap = POINTER(struct_ifaddrs)()
    result = libc.getifaddrs(pointer(ifap))
    if result != 0:
        raise OSError(get_errno())
    del result
    try:
        retval = {}
        for ifa in ifap_iter(ifap):
            name = ifa.ifa_name
            i = retval.get(name)
            if not i:
                i = retval[name] = NetworkInterface(name)
            try:
                family, addr = getfamaddr(ifa.ifa_addr.contents)
            except ValueError:
                family, addr = None, None
            if addr:
                i.addresses[family] = addr
        return retval.values()
    finally:
        libc.freeifaddrs(ifap)

if __name__ == '__main__':
    print [str(ni) for ni in get_network_interfaces()]
```


## Ref


[get-local-network-interface-addresses-using-only-proc](https://stackoverflow.com/questions/5281341/get-local-network-interface-addresses-using-only-proc)
