## 替换带有证书链的证书

### apache

需要一拆为二，一个是cer，一个是ca.crt（根证书），然后分别替换quanshi.cer和ca.crt，之后重启Apache。  

### nginx

不用拆分，只需要替换cer或crt文件就行

### haproxy

将证书及密钥文件，按照顺序拼接在一样来创建pem 文件。

```shell
cat /etc/ssl/yourdomain.crt /etc/ssl/yourdomain.key | sudo tee /etc/ssl/yourdomain.pem
```
