#!/bin/bash
DATE=$(date +%F_%H-%M-%S)
# 数据库所在服务器地址
HOST=127.0.0.1
# 要备份的数据库名
DB=test
# 数据库用户名
USER=test
#数据库密码
PASS=test
#备份文件保存路径
BACKUP_DIR=/data/backup/mysql
if [ ! -d "$BACKUP_DIR" ];then
    mkdir -p $BACKUP_DIR
fi
SQL_FILE=${DB}_FULL_${DATE}.sql
BAK_FILE=${DB}_FULL_${DATE}.tar.gz
cd $BACKUP_DIR
if mysqldump -h$HOST -u$USER -p$PASS -B $DB > $SQL_FILE; then
    tar -czvf $BAK_FILE $SQL_FILE
    if [ -s $BAK_FILE ]; then
        echo "$DATA backup successed!!!" && rm $SQL_FILE
    fi
    else
        echo "$DATE backup error"
fi
find $BACK_DIR -name "*.tar.gz" -ctime +14 -exec rm {} \;