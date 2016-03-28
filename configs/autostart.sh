#!/bin/bash
service ssh start
service mysql start
service zabbix-server start



#Create Database
echo "create database zabbix;" | mysql -uroot -proot
echo "CREATE USER 'zabbix'@'%' IDENTIFIED BY 'zabbix';" | mysql -uroot -proot
echo "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%';" | mysql -uroot -proot
gzip -d /usr/share/doc/zabbix-server-mysql/create.sql.gz
mysql -uzabbix -pzabbix zabbix < /usr/share/doc/zabbix-server-mysql/create.sql




#Set zabbix configuration
echo "
ListenPort=10051
LogFile=/var/log/zabbix/zabbix_server.log
LogFileSize=0
PidFile=/var/run/zabbix/zabbix_server.pid

DBName=zabbix
DBUser=zabbix
DBPassword=zabbix
DBPort=3306

Timeout=4

AlertScriptsPath=/usr/lib/zabbix/alertscripts
ExternalScripts=/usr/lib/zabbix/externalscripts
FpingLocation=/usr/bin/fping
Fping6Location=/usr/bin/fping6
LogSlowQueries=3000
" >  /etc/zabbix/zabbix_server.conf
service zabbix-server restart




#Rewrite autostart
echo "
#!/bin/bash
service ssh start
service mysql start
service apache2 start
service zabbix-server start
" > /root/autostart.sh
