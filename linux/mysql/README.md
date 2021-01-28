## 多条 insert 语句合并

以下两个脚本均可，第二个只使用一次 `awk` 
```
gen_insert_sql.sh 
gen_insert_sql_using_awk.sh
```

**转换前**

```
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100004', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100008', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100012', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100016', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100020', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100024', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100028', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100032', '0');
```

**转换后**

```
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100004', '0'),
('1148100008', '0'),
('1148100012', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100016', '0'),
('1148100020', '0'),
('1148100024', '0');
INSERT INTO `PreTempConfId` (`tempConfId`, `useFlag`) VALUES ('1148100028', '0'),
('1148100032', '0');
```
