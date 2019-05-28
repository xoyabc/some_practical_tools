
## 从文件中加载列表

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
```
# you cannot iterate while modifying the dict
# 1, use list(RESULT) to force a copy of keys to be made
# 2, use deep copy, RESULT.copy()
```

```python
1, for m in list(RESULT):
2, RESULT.copy()

for m in RESULT.copy():
    if k == m:
        continue
    else:
        RESULT[k] = v
```






