
-- Create a base table to be used for loading data: Begin
drop table if exists testAltCol;
create table testAltCol
(cId        TINYINT,
 cTimeStamp TIMESTAMP,
 cDecimal   DECIMAL(38,18),
 cDouble    DOUBLE,
 cFloat     FLOAT,
 cBigInt    BIGINT,
 cInt       INT,
 cSmallInt  SMALLINT,
 cTinyint   TINYINT,
 cBoolean   BOOLEAN);

insert into testAltCol values
(1,
 '2017-11-07 09:02:49.999999999',
 12345678901234567890.123456789012345678,
 1.79e308,
 3.4e38,
 1234567890123456789,
 1234567890,
 12345,
 123,
 TRUE);

insert into testAltCol values
(2,
 '1400-01-01 01:01:01.000000001',
 1.1,
 2.2,
 3.3,
 1,
 2,
 3,
 4,
 FALSE);

insert into testAltCol values
(3,
 '1400-01-01 01:01:01.000000001',
 10.1,
 20.2,
 30.3,
 1234567890123456789,
 1234567890,
 12345,
 123,
 TRUE);

insert into testAltCol values
(4,
 '1400-01-01 01:01:01.000000001',
 -10.1,
 -20.2,
 -30.3,
 -1234567890123456789,
 -1234567890,
 -12345,
 -123,
 FALSE);

select cId, cTimeStamp from testAltCol order by cId;
select cId, cDecimal, cDouble, cFloat from testAltCol order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltCol order by cId;
select cId, cBoolean from testAltCol order by cId;
-- Create a base table to be used for loading data: Begin

-- Enable change of column type
SET hive.metastore.disallow.incompatible.col.type.changes=false;

-- Text type: Begin
-- timestamp, decimal, double, float, bigint, int, smallint, tinyint and boolean: after type
-- changed to string, varchar and char return correct data.
drop table if exists testAltColT;

create table testAltColT stored as textfile as select * from testAltCol;

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;

alter table testAltColT replace columns
(cId        TINYINT,
 cTimeStamp STRING,
 cDecimal   STRING,
 cDouble    STRING,
 cFloat     STRING,
 cBigInt    STRING,
 cInt       STRING,
 cSmallInt  STRING,
 cTinyint   STRING,
 cBoolean   STRING);

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;

alter table testAltColT replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(100),
 cDecimal   VARCHAR(100),
 cDouble    VARCHAR(100),
 cFloat     VARCHAR(100),
 cBigInt    VARCHAR(100),
 cInt       VARCHAR(100),
 cSmallInt  VARCHAR(100),
 cTinyint   VARCHAR(100),
 cBoolean   VARCHAR(100));

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;

alter table testAltColT replace columns
(cId        TINYINT,
 cTimeStamp CHAR(100),
 cDecimal   CHAR(100),
 cDouble    CHAR(100),
 cFloat     CHAR(100),
 cBigInt    CHAR(100),
 cInt       CHAR(100),
 cSmallInt  CHAR(100),
 cTinyint   CHAR(100),
 cBoolean   CHAR(100));

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;

alter table testAltColT replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(4),
 cDecimal   VARCHAR(4),
 cDouble    VARCHAR(4),
 cFloat     VARCHAR(4),
 cBigInt    VARCHAR(4),
 cInt       VARCHAR(4),
 cSmallInt  VARCHAR(4),
 cTinyint   VARCHAR(4),
 cBoolean   VARCHAR(4));

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;

alter table testAltColT replace columns
(cId        TINYINT,
 cTimeStamp CHAR(4),
 cDecimal   CHAR(4),
 cDouble    CHAR(4),
 cFloat     CHAR(4),
 cBigInt    CHAR(4),
 cInt       CHAR(4),
 cSmallInt  CHAR(4),
 cTinyint   CHAR(4),
 cBoolean   CHAR(4));

select cId, cTimeStamp from testAltColT order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColT order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColT order by cId;
select cId, cBoolean from testAltColT order by cId;
drop table if exists testAltColT;
-- Text type: End

-- Sequence File type: Begin
-- timestamp, decimal, double, float, bigint, int, smallint, tinyint and boolean: after type
-- changed to string, varchar and char return correct data.
drop table if exists testAltColSF;

create table testAltColSF stored as sequencefile as select * from testAltCol;

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

alter table testAltColSF replace columns
(cId        TINYINT,
 cTimeStamp STRING,
 cDecimal   STRING,
 cDouble    STRING,
 cFloat     STRING,
 cBigInt    STRING,
 cInt       STRING,
 cSmallInt  STRING,
 cTinyint   STRING,
 cBoolean   STRING);

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

alter table testAltColSF replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(100),
 cDecimal   VARCHAR(100),
 cDouble    VARCHAR(100),
 cFloat     VARCHAR(100),
 cBigInt    VARCHAR(100),
 cInt       VARCHAR(100),
 cSmallInt  VARCHAR(100),
 cTinyint   VARCHAR(100),
 cBoolean   VARCHAR(100));

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

alter table testAltColSF replace columns
(cId        TINYINT,
 cTimeStamp CHAR(100),
 cDecimal   CHAR(100),
 cDouble    CHAR(100),
 cFloat     CHAR(100),
 cBigInt    CHAR(100),
 cInt       CHAR(100),
 cSmallInt  CHAR(100),
 cTinyint   CHAR(100),
 cBoolean   CHAR(100));

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

alter table testAltColSF replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(4),
 cDecimal   VARCHAR(4),
 cDouble    VARCHAR(4),
 cFloat     VARCHAR(4),
 cBigInt    VARCHAR(4),
 cInt       VARCHAR(4),
 cSmallInt  VARCHAR(4),
 cTinyint   VARCHAR(4),
 cBoolean   VARCHAR(4));

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

alter table testAltColSF replace columns
(cId        TINYINT,
 cTimeStamp CHAR(4),
 cDecimal   CHAR(4),
 cDouble    CHAR(4),
 cFloat     CHAR(4),
 cBigInt    CHAR(4),
 cInt       CHAR(4),
 cSmallInt  CHAR(4),
 cTinyint   CHAR(4),
 cBoolean   CHAR(4));

select cId, cTimeStamp from testAltColSF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColSF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColSF order by cId;
select cId, cBoolean from testAltColSF order by cId;

drop table if exists testAltColSF;
-- Sequence File type: End

-- ORC type: Begin
-- timestamp, decimal, double, float, bigint, int, smallint, tinyint and boolean: after type
-- changed to string, varchar and char return correct data.
drop table if exists testAltColORC;

create table testAltColORC stored as orc as select * from testAltCol;

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

alter table testAltColORC replace columns
(cId        TINYINT,
 cTimeStamp STRING,
 cDecimal   STRING,
 cDouble    STRING,
 cFloat     STRING,
 cBigInt    STRING,
 cInt       STRING,
 cSmallInt  STRING,
 cTinyint   STRING,
 cBoolean   STRING);

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

alter table testAltColORC replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(100),
 cDecimal   VARCHAR(100),
 cDouble    VARCHAR(100),
 cFloat     VARCHAR(100),
 cBigInt    VARCHAR(100),
 cInt       VARCHAR(100),
 cSmallInt  VARCHAR(100),
 cTinyint   VARCHAR(100),
 cBoolean   VARCHAR(100));

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

alter table testAltColORC replace columns
(cId        TINYINT,
 cTimeStamp CHAR(100),
 cDecimal   CHAR(100),
 cDouble    CHAR(100),
 cFloat     CHAR(100),
 cBigInt    CHAR(100),
 cInt       CHAR(100),
 cSmallInt  CHAR(100),
 cTinyint   CHAR(100),
 cBoolean   CHAR(100));

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

alter table testAltColORC replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(4),
 cDecimal   VARCHAR(4),
 cDouble    VARCHAR(4),
 cFloat     VARCHAR(4),
 cBigInt    VARCHAR(4),
 cInt       VARCHAR(4),
 cSmallInt  VARCHAR(4),
 cTinyint   VARCHAR(4),
 cBoolean   VARCHAR(4));

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

alter table testAltColORC replace columns
(cId        TINYINT,
 cTimeStamp CHAR(4),
 cDecimal   CHAR(4),
 cDouble    CHAR(4),
 cFloat     CHAR(4),
 cBigInt    CHAR(4),
 cInt       CHAR(4),
 cSmallInt  CHAR(4),
 cTinyint   CHAR(4),
 cBoolean   CHAR(4));

select cId, cTimeStamp from testAltColORC order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColORC order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColORC order by cId;
select cId, cBoolean from testAltColORC order by cId;

drop table if exists testAltColORC;
-- ORC type: End

-- RCFile type: Begin
-- timestamp, decimal, double, float, bigint, int, smallint, tinyint and boolean: after type
-- changed to string, varchar and char return correct data.
drop table if exists testAltColRCF;

create table testAltColRCF stored as rcfile as select * from testAltCol;

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

alter table testAltColRCF replace columns
(cId        TINYINT,
 cTimeStamp STRING,
 cDecimal   STRING,
 cDouble    STRING,
 cFloat     STRING,
 cBigInt    STRING,
 cInt       STRING,
 cSmallInt  STRING,
 cTinyint   STRING,
 cBoolean   STRING);

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

alter table testAltColRCF replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(100),
 cDecimal   VARCHAR(100),
 cDouble    VARCHAR(100),
 cFloat     VARCHAR(100),
 cBigInt    VARCHAR(100),
 cInt       VARCHAR(100),
 cSmallInt  VARCHAR(100),
 cTinyint   VARCHAR(100),
 cBoolean   VARCHAR(100));

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

alter table testAltColRCF replace columns
(cId        TINYINT,
 cTimeStamp CHAR(100),
 cDecimal   CHAR(100),
 cDouble    CHAR(100),
 cFloat     CHAR(100),
 cBigInt    CHAR(100),
 cInt       CHAR(100),
 cSmallInt  CHAR(100),
 cTinyint   CHAR(100),
 cBoolean   CHAR(100));

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

alter table testAltColRCF replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(4),
 cDecimal   VARCHAR(4),
 cDouble    VARCHAR(4),
 cFloat     VARCHAR(4),
 cBigInt    VARCHAR(4),
 cInt       VARCHAR(4),
 cSmallInt  VARCHAR(4),
 cTinyint   VARCHAR(4),
 cBoolean   VARCHAR(4));

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

alter table testAltColRCF replace columns
(cId        TINYINT,
 cTimeStamp CHAR(4),
 cDecimal   CHAR(4),
 cDouble    CHAR(4),
 cFloat     CHAR(4),
 cBigInt    CHAR(4),
 cInt       CHAR(4),
 cSmallInt  CHAR(4),
 cTinyint   CHAR(4),
 cBoolean   CHAR(4));

select cId, cTimeStamp from testAltColRCF order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColRCF order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColRCF order by cId;
select cId, cBoolean from testAltColRCF order by cId;

drop table if exists testAltColRCF;
-- RCFile type: End

-- Parquet type: Begin
drop table if exists testAltColP;
create table testAltColP stored as parquet as select * from testAltCol;

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

alter table testAltColP replace columns
(cId        TINYINT,
 cTimeStamp STRING,
 cDecimal   STRING,
 cDouble    STRING,
 cFloat     STRING,
 cBigInt    STRING,
 cInt       STRING,
 cSmallInt  STRING,
 cTinyint   STRING,
 cBoolean   STRING);

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

alter table testAltColP replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(100),
 cDecimal   VARCHAR(100),
 cDouble    VARCHAR(100),
 cFloat     VARCHAR(100),
 cBigInt    VARCHAR(100),
 cInt       VARCHAR(100),
 cSmallInt  VARCHAR(100),
 cTinyint   VARCHAR(100),
 cBoolean   VARCHAR(100));

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

alter table testAltColP replace columns
(cId        TINYINT,
 cTimeStamp CHAR(100),
 cDecimal   CHAR(100),
 cDouble    CHAR(100),
 cFloat     CHAR(100),
 cBigInt    CHAR(100),
 cInt       CHAR(100),
 cSmallInt  CHAR(100),
 cTinyint   CHAR(100),
 cBoolean   CHAR(100));

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

alter table testAltColP replace columns
(cId        TINYINT,
 cTimeStamp VARCHAR(4),
 cDecimal   VARCHAR(4),
 cDouble    VARCHAR(4),
 cFloat     VARCHAR(4),
 cBigInt    VARCHAR(4),
 cInt       VARCHAR(4),
 cSmallInt  VARCHAR(4),
 cTinyint   VARCHAR(4),
 cBoolean   VARCHAR(4));

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

alter table testAltColP replace columns
(cId        TINYINT,
 cTimeStamp CHAR(4),
 cDecimal   CHAR(4),
 cDouble    CHAR(4),
 cFloat     CHAR(4),
 cBigInt    CHAR(4),
 cInt       CHAR(4),
 cSmallInt  CHAR(4),
 cTinyint   CHAR(4),
 cBoolean   CHAR(4));

select cId, cTimeStamp from testAltColP order by cId;
select cId, cDecimal, cDouble, cFloat from testAltColP order by cId;
select cId, cBigInt, cInt, cSmallInt, cTinyint from testAltColP order by cId;
select cId, cBoolean from testAltColP order by cId;

drop table if exists testAltColP;
-- Parquet type: End

drop table if exists testAltCol;