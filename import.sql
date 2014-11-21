SET @file := '';

CREATE TABLE IF NOT EXISTS `tmp` (
  `start` varchar(64) NOT NULL,
  `end` varchar(64) NOT NULL,
  `country` varchar(16) NOT NULL,
  `region` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOAD DATA INFILE @file
  INTO TABLE `tmp`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n';

DELETE FROM `tmp`
  WHERE
    `start` LIKE '%:%' OR
    `end` LIKE '%:%';

CREATE TABLE IF NOT EXISTS `region` (
`id` int(10) unsigned NOT NULL COMMENT '#',
  `country` enum('AD','AE','AF','AG','AI','AL','AM','AN','AO','AQ','AR','AS','AT','AU','AW','AX','AZ','BA','BB','BD','BE','BF','BG','BH','BI','BJ','BL','BM','BN','BO','BQ','BR','BS','BT','BV','BW','BY','BZ','CA','CC','CD','CF','CG','CH','CI','CK','CL','CM','CN','CO','CR','CS','CU','CV','CW','CX','CY','CZ','DE','DJ','DK','DM','DO','DZ','EC','EE','EG','EH','ER','ES','ET','FI','FJ','FK','FM','FO','FR','FX','GA','GB','GD','GE','GF','GG','GH','GI','GL','GM','GN','GP','GQ','GR','GS','GT','GU','GW','GY','HK','HM','HN','HR','HT','HU','ID','IE','IL','IM','IN','IO','IQ','IR','IS','IT','JE','JM','JO','JP','KE','KG','KH','KI','KM','KN','KP','KR','KW','KY','KZ','LA','LB','LC','LI','LK','LR','LS','LT','LU','LV','LY','MA','MC','MD','ME','MF','MG','MH','MK','ML','MM','MN','MO','MP','MQ','MR','MS','MT','MU','MV','MW','MX','MY','MZ','NA','NC','NE','NF','NG','NI','NL','NO','NP','NR','NU','NZ','OM','PA','PE','PF','PG','PH','PK','PL','PM','PN','PR','PS','PT','PW','PY','QA','RE','RO','RS','RU','RW','SA','SB','SC','SD','SE','SG','SH','SI','SJ','SK','SL','SM','SN','SO','SR','SS','ST','SV','SY','SZ','TC','TD','TF','TG','TH','TJ','TK','TL','TM','TN','TO','TP','TR','TT','TV','TW','TZ','UA','UG','UM','US','UY','UZ','VA','VC','VE','VG','VI','VN','VU','WF','WS','YE','YT','YU','ZA','ZM','ZW') NOT NULL COMMENT 'Страна',
  `region` varchar(128) NOT NULL COMMENT 'Регион',
  `city` varchar(128) NOT NULL COMMENT 'Город',
  `start` int(10) unsigned NOT NULL COMMENT 'начало зоны ip',
  `end` int(10) unsigned NOT NULL COMMENT 'конец зоны ip'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='region';
ALTER TABLE `region`
 ADD PRIMARY KEY (`id`), ADD KEY `start` (`start`,`end`);

ALTER TABLE `region`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '#';

INSERT INTO `region`
  SELECT
    NULL, country, region, city, INET_ATON(start), INET_ATON(end)
  FROM
    tmp;
