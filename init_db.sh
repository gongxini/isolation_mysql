#!/bin/bash

if [ ! -d dist ]; then
  echo "dist directory does not exist. Must be called after compile.sh succeeds."
  exit 1
fi

cd dist

if [ ! -x bin/mysqld -o ! -x scripts/mysql_install_db ]; then
  echo "bin/mysqld or scripts/mysql_install_db does not exist"
  exit 1
fi

basedir=`pwd`

echo "my.cnf..."

cp ../my.cnf .

echo "Installing db..."
scripts/mysql_install_db  --basedir=$basedir --datadir=$basedir/data

echo "Creating initial tables and data..."
./bin/mysqld --defaults-file=my.cnf  &
sleep 10
./bin/mysql -S mysqld.sock << EOF
use test;
CREATE TABLE tbl(id INT NOT NULL AUTO_INCREMENT,col INT NOT NULL, PRIMARY KEY (id)) Engine = InnoDB;
INSERT INTO tbl(col) VALUES(11);
INSERT INTO tbl(col) VALUES(12);
INSERT INTO tbl(col) VALUES(13);
INSERT INTO tbl(col) VALUES(14);
INSERT INTO tbl(col) VALUES(15);
INSERT INTO tbl(col) VALUES(16);
INSERT INTO tbl(col) VALUES(17);
INSERT INTO tbl(col) VALUES(18);
INSERT INTO tbl(col) VALUES(19);
INSERT INTO tbl(col) VALUES(20);
INSERT INTO tbl(col) VALUES(21);
INSERT INTO tbl(col) VALUES(22);
INSERT INTO tbl(col) VALUES(23);
INSERT INTO tbl(col) VALUES(24);
INSERT INTO tbl(col) VALUES(25);
INSERT INTO tbl(col) VALUES(26);
INSERT INTO tbl(col) VALUES(27);
INSERT INTO tbl(col) VALUES(28);
INSERT INTO tbl(col) VALUES(29);
INSERT INTO tbl(col) VALUES(30);
CREATE TABLE tbl1(id INT NOT NULL AUTO_INCREMENT,col INT NOT NULL, PRIMARY KEY (id)) Engine = MyISAM;
INSERT INTO tbl1(col) VALUES(31);
INSERT INTO tbl1(col) VALUES(32);
INSERT INTO tbl1(col) VALUES(33);
INSERT INTO tbl1(col) VALUES(34);
EOF
./bin/mysqladmin -S mysqld.sock -u root shutdown

echo "Successfully initialized mysql db"
