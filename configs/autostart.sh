#!/bin/bash
service ssh start
service mysql start
service nginx start
service zabbix-server start

#Create Database
echo "create database zabbix;" | mysql -uroot -proot
echo "CREATE USER 'zabbix'@'%' IDENTIFIED BY 'zabbix';" | mysql -uroot -proot
echo "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';" | mysql -uroot -proot
mysql -uzabbix -pzabbix zabbix < /usr/share/zabbix-server-mysql/schema.sql
mysql -uzabbix -pzabbix zabbix < /usr/share/zabbix-server-mysql/images.sql
mysql -uzabbix -pzabbix zabbix < /usr/share/zabbix-server-mysql/data.sql

#Rewrite autostart
echo "
#!/bin/bash
service ssh start
service mysql start
service nginx start
service zabbix-server start
" > /root/autostart.sh
