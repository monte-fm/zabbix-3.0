#!/bin/bash
service ssh start
service mysql start
service nginx start
service zabbix-server start

#Create Database
echo "create database zabbix;" | mysql -uroot -proot
echo "CREATE USER 'zabbix'@'%' IDENTIFIED BY 'zabbix';" | mysql -uroot -proot
echo "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';" | mysql -uroot -proot
gzip -d /usr/share/doc/zabbix-server-mysql/create.sql.gz
mysql -uzabbix -pzabbix zabbix < /usr/share/doc/zabbix-server-mysql/create.sql

#Rewrite autostart
echo "
#!/bin/bash
service ssh start
service mysql start
service nginx start
service zabbix-server start
" > /root/autostart.sh
