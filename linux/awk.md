<!--ts-->
      * [时间函数](#时间函数)
         * [strftime 将时间戳转日期](#strftime-将时间戳转日期)
         * [将日期转为时间戳](#将日期转为时间戳)
         * [获取当前时间戳及时间戳互转](#获取当前时间戳及时间戳互转)
      * [获取最近1小时内critical级别日志条数](#获取最近1小时内critical级别日志条数)


<!--te-->

## 时间函数

### strftime 将时间戳转日期
```bash
awk 'BEGIN{print strftime("%Y-%m-%d",systime())}'
```
### 将日期转为时间戳
```bash
awk 'BEGIN {printf("%d\n",mktime(2006" "8" "5" "15" "09" "0))}'
```

### 获取当前时间戳及时间戳互转

```awk
BEGIN{
}
{
    # 获取当前时间戳
    timestamp = systime();
    print(timestamp);

    # 获取指定时间时间戳
    timestamp = mktime("2015 07 25 15 58 48");
    print(timestamp);

    # 获取当前时间字符串
    print(strftime("%Y-%m-%d %H:%M:%S"));
    # 获取指定时间戳的时间字符串
    print(strftime("%Y-%m-%d %H:%M:%S", timestamp));
}
END{
}
```

>$echo ""|awk -f chapter_4_2-1.awk

>1554012550

>1437811128

>2019-03-31 14:09:10

>2015-07-25 15:58:48


## 获取最近1小时内critical级别日志条数

日志内容

```plain
$cat test.file                                            
2019-03-31 13:07:03 localhost server[15152]: crit <gid:17774554>[joinConference.go:129:server/Conference] JoinConference from cms failed, url:http://www.test.com/cmsrest/6666666,body:<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
2019-03-31 13:27:03 localhost server[15152]: crit cmsrest
2019-03-31 13:27:03 localhost server[15152]: info cmsrest
2019-03-31 13:27:03 localhost server[15152]: crit <gid:17774554>[joinConference.go:129:server/Conference] JoinConference from cms failed, url:http://www.test.com/cmsrest/6666666,body:<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
2019-03-31 13:28:03 localhost server[15152]: crit <gid:17774554>[joinConference.go:129:server/Conference] JoinConference from cms failed, url:http://www.test.com/cmsrest/6666666,body:<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
```

awk文件内容

```awk
BEGIN{num=0;}
/crit/{
interval= 3600;
timestamp = systime();
timestamp2 = timestamp-interval;
split ($1,day,"-");
split ($2,time,":");
$2 = null;
$1 = mktime(day[1]" "day[2]" "day[3]" "time[1]" "time[2]" "time[3]);
if($1<=timestamp && $1>timestamp2) {
num++
}
}
END{
print num
}
```


```bash
$cat test.file |awk -f crit_log_num.awk 
3

或
$cat test.file |awk --re-interval 'BEGIN{num=0}/crit/{timestamp = systime();timestamp2 = timestamp-6600;split ($1,day,"-");split ($2,time,":");$2=null;$1=mktime(day[1]" "day[2]" "day[3]" "time[1]" "time[2]" "time[3]);if($1<=timestamp && $1>timestamp2) {num+=1}}END{print num}'
4
```















