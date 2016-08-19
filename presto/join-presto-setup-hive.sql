
!echo # join-presto-data-setup-hive.sql;

USE default;
DROP DATABASE IF EXISTS benchmark CASCADE;
CREATE DATABASE benchmark COMMENT 'part of H2O h2oai/db-benchmark';
USE benchmark;

!echo ${SRC_X_DIR};
!echo ${SRC_Y_DIR};

!echo hive-out-data-setup-body;

CREATE EXTERNAL TABLE src_x (KEY INT, X2 INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ","
STORED AS TEXTFILE
LOCATION "${SRC_X_DIR}"
TBLPROPERTIES('skip.header.line.count'='1')
;

CREATE EXTERNAL TABLE src_y (KEY INT, Y2 INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ","
STORED AS TEXTFILE
LOCATION "${SRC_Y_DIR}"
TBLPROPERTIES('skip.header.line.count'='1')
;

CREATE TABLE x STORED AS ORC TBLPROPERTIES ("orc.compress"="SNAPPY") AS SELECT CAST(KEY AS INT) KEY, CAST(X2 AS INT) X2 FROM src_x WHERE key IS NOT NULL;
CREATE TABLE y STORED AS ORC TBLPROPERTIES ("orc.compress"="SNAPPY") AS SELECT CAST(KEY AS INT) KEY, CAST(Y2 AS INT) Y2 FROM src_y WHERE key IS NOT NULL;

!echo hive-out-data-setup-body;

CREATE TABLE x_count AS SELECT COUNT(*) in_rows FROM x;
CREATE TABLE y_count AS SELECT COUNT(*) in_rows FROM y;

EXIT;