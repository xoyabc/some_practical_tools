# LAN & WAN
## LAN
### method 1
ip a |egrep '\beth[0-9]\b|\bens3[0-9]\b' |grep -Ev '127.0.0.1|32 scope|secondary|eth[0-9]:' |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |grep -E '172\.|192\.|10\.'
### method 2
ip a|egrep '\beth[0-9]\b|\bens[0-9]{2}\b'|grep -v secondary|grep brd |awk '$2~/^10.|^192.168.|^172.(1[6-9]|2[0-9]|3[0-1])/{split($2,a,"/");print a[1]}'
## WAN
ip a |egrep '\beth[0-9]\b|\bens3[0-9]\b' |grep -Ev '127.0.0.1|32 scope|secondary|eth[0-9]:' |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |grep -Ev '1\.|172\.|192\.|10\.'

# VIP: WAN & LAN (eth or ens33)
## LAN
ip a |egrep '\beth[0-9]\b|\blo\b|\bens3[0-9]\b' |grep -E 'secondary|:|ens' |grep -E '32 scope|secondary|eth[0-9]:' |grep -E 'eth[0-9]|ens3[0-9]' |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort |grep -E '1\.|172\.|192\.|10\.'
## WAN
ip a |egrep '\beth[0-9]\b|\blo\b|\bens3[0-9]\b' |grep -E 'secondary|:|ens' |grep -E '32 scope|secondary|eth[0-9]:' |grep -E 'eth[0-9]|ens3[0-9]' |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort |grep -Ev '1\.|172\.|192\.|10\.'

# VIP: WAN & LAN (lo interface)
## LAN
ip a |egrep '\blo\b' |grep -Ev 127.0.0.1 |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort -nu |grep -E '1\.|172\.|192\.|10\.'
## WAN
ip a |egrep '\blo\b' |grep -Ev 127.0.0.1 |awk '{print $2}' |egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sort -nu |grep -Ev '1\.|172\.|192\.|10\.'
