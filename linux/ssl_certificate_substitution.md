# 替换带有证书链的证书

证书格式：用户证书(crt)--中间证书(chain)–根证书(root)（根证书可无）
Apache：用户证书+私钥+证书链
nginx：证书：用户证书+证书链 ，私钥
haproxy： 将证书+密钥+证书认证中心证书（可有可无）按顺序拼接在一起。
对于证书认证中心证书，已知小米手机检查较严，pem 文件中 需要配置，否则会提示“当前网站证书不可信且证书链长度为1，可能是服务器没有配置完整证书链”


## apache

Apache需要一拆为二，前半段是域名证书，后半段是中级CA证书（根证书），然后分别替换 yourdomain.cer 和 ca.crt，之后重启Apache。 

apache 证书配置：

```
SSLCertificateFile "/etc/apache2/ssl/yourdomain.cer"
SSLCertificateKeyFile "/etc/apache2/ssl/yourdomain.key"
SSLCertificateChainFile "/etc/apache2/ssl/ca.crt"
```

替换步骤：

```
备份
cp /etc/apache2/ssl/ca.crt /etc/apache2/ssl/ca.crt.bak
cp /etc/apache2/ssl/yourdomain.cer /etc/apache2/ssl/yourdomain.cer.bak

替换
cd /etc/apache2/ssl/
wget -N http://192.168.1.100:8080/conf/sslcertificate/apache/ca.crt
wget -N http://192.168.1.100:8080/conf/sslcertificate/apache/yourdomain.cer

重启
/etc/init.d/apache2 restart
```


## nginx

不用拆分，只需要替换cer或crt文件就行

替换步骤:

```
cd /usr/local/openresty/nginx/conf/ssl
cp quanshi.cer quanshi.cer.bak
cd /usr/local/openresty/nginx/conf/ssl && wget -N http://192.168.1.100:8080/conf/sslcertificate/nginx/quanshi.cer

重启
/etc/init.d/openresty restart
```

## haproxy

将证书及密钥文件，按照顺序拼接在一样来创建pem 文件。

```shell
cat /etc/ssl/yourdomain.crt /etc/ssl/yourdomain.key /etc/ssl/chain.crt | sudo tee /etc/ssl/yourdomain.pem
```

替换步骤：

```
备份：
cp /data/ssl/yourdomain.pem /data/ssl/yourdomain.pem.old
替换
wget -SO /data/ssl/yourdomain.pem http://192.168.1.100:8080/conf/sslcertificate/haproxy/yourdomain.pem
重启
/etc/init.d/haproxy restart
```
