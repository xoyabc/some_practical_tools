
## 从文件中加载列表

文件格式示例
```
1 2 3
4 5 6
```
    list_device_group = []
    def load_list_from_file(filepath):
        with open(filepath,'rU') as f:
            for line in f:
                separator=' '
                item = "-".join(line.strip().decode('utf-8').split(separator)[0:3])
                list_device_group.append(item)
            return list_device_group

## 从文件中加载json

    #!/usr/bin/env python
    # -*- coding:utf-8 -*-
    import re
    import string
    import json
    import sys
    reload(sys)
    sys.setdefaultencoding('utf8')
    f = open("/tmp/test.file")
    data = json.load(f).encode('UTF-8')
    print data[0]['admin_name']

## 请求api，返回json

#### convert to json data 1

    def json_loads(ip):
        url = 'http://192.168.5.19/api/v1/getVmarehost?private_ip_address=172.17.100.21' %ip
        res=requests.get(url)
        json_data=res.json()
        #mrtgs = json_data.get("data")[0].get("mrtgs")[0]
        return json_data

#### convert to json data 2
    # do not verify ssl
    context = ssl._create_unverified_context()
    def json_loads(url):
        response = urllib2.urlopen(url, context=context)
        html=response.read()
        data = json.loads(html)
        return data
        
#### convert to json data using urllib2
```python
def json_loads(url):
    response = urllib2.urlopen(url)
    html=response.read()
    data = json.loads(html)
    return data
```

## 列表循环

for i,v in enumerate(info_list):

    for i,v in enumerate(info_list):
        if '导演:' in v:
            print info_list[i+1]
        elif '主演:' in v:
            print info_list[i+1]
        elif '片国家/地区:' in v:
            print info_list[i+1]
        elif '语言:' in v:
            print info_list[i+1]
        elif 'IMDb链接:' in  v:
            print info_list[i+1]


## 循环字典同时修改数据

[modifying-a-python-dict-while-iterating-over-it ](https://stackoverflow.com/questions/6777485/modifying-a-python-dict-while-iterating-over-it)

[user_mgt_system_v2_dict_and_file.py]( https://github.com/51reboot/xly1/blob/master/lesson03/louxiaohui/user_mgt_system_v2_dict_and_file.py)

```
# you cannot iterate while modifying the dict
# 1, use list(RESULT) to force a copy of keys to be made
# 2, use deep copy, RESULT.copy()
```

```python
1, for m in list(RESULT):
2, RESULT.copy()

for k, v in RESULT_DICT.items():
    #for m in list(RESULT):
    for m in RESULT.copy():
        if k == m:
            continue
        else:
            RESULT[k] = v
```

## 解决 csv 写入中文乱码

如果将包含中文的结果输出到csv文件，一般默认使用Excel打开文件时，文件内容会出现乱码，而使用文本编辑器打开不会乱码。这是因为Excel默认的编码方式为‘GBK‘，而文本编辑器默认的格式为‘utf-8'。

使用codecs包在创建文件后添加语句f.write(codecs.BOM_UTF8)可解

- python 2.7

```python
import csv
import codecs
f = file('test.csv', 'wb')
# excel打开内容不乱码的核心语句
f.write(codecs.BOM_UTF8)
writer = csv.writer(f)
writer.writerow(['姓名', '年龄', '电话'])
```

- python 3.x

```python
with open(filename, 'a', newline='', encoding='utf-8-sig') as f: # 中文需要设置成utf-8格式
f_csv = csv.writer(f)
    f_csv.writerow(('城市', '日期', '天气', '风力', '温度', '摄氏度')) # 头部信息
    f_csv.writerows(data)
```

## write the list to result file


```python
def write_to_file(file, *info_list):
    with open(file, 'w')  as f:
        f.writelines(str(line) + "\n" for line in info_list)
```
        
## insert fisrt line

```python
def line_prepender(filename, line):
    with open(filename, 'r+') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)
```

head_instruction = "subject_id\ttype\t中文名\t年份\t片长\t评分\t评价人数\t国家\t语言\t类型\t主演\t导演\tIMDB编号"
line_prepender('test.txt', head_instruction)


## TypeError: string indices must be integers


data 为返回数据。

- 1， 需要使用data=json.loads(data)  //将字符串转成json格式，或 data=eval(data)  //将字符串转成dict格式。

```python
In [38]: s = {'userBasicInfoId': 7714931}                                                     

In [39]: data = json.dumps(s)                                                                 

In [40]: data['userBasicInfoId']                                                              
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-40-1a8a364a2793> in <module>
----> 1 data['userBasicInfoId']

TypeError: string indices must be integers
```

2， data为字符串，非字典类型，即使使用`json.loads()` 转换后也不行，此时需要使用 try 作异常判断。

```python
In [29]: core_data = 'user with umsUserId=9993006 and userType=125 not found.'                

In [30]: core_data['billingCode']                                                             
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-30-4b8cc8c94bac> in <module>
----> 1 core_data['billingCode']

TypeError: string indices must be integers
```

## 列表求交集或共同元素

1，求两个

### method 1

```python
def get_common_data(l1, l2):
    common_list = []
    for i in l1:
        if len(list(filter(lambda x: x == i, l2))) > 0:
            common_list.append(i)
    return common_list
```

### method 2

```python
[ i for i in a if i in b ]
```

2，求多个

```python
def get_common_data_multi(l1, *info_list): 
    for l in info_list: 
        common_list = [] 
        for i in l:
            if len(list(filter(lambda x: x == i, l1))) > 0:
                common_list.append(i) 
        l1 = common_list
    return common_list
    
或（https://www.zhihu.com/question/37422498）
In [1]: L = [[1,2,3,4], [2,3,4,5], [3,4,5,6],[1,2,3,4,5,6]]

In [2]: set(L[0]).intersection(*L[1:])
Out[2]: {3, 4}
```

