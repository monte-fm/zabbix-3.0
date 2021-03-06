# Zabbix Web login
```
User: Admin
password: zabbix
```

# Zabbix agent config
```
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0

Server=<server_name>
ListenPort=10050

Hostname=zabbix-agent-server
Include=/etc/zabbix/zabbix_agentd.d/
```

# Create container
```
docker run -it -d --name=zabbix -h=zabbix -p 1080:80 -p 1022:22 -p 10051:10051 cristo/zabbix-3.0 /bin/bash
```

# MySQL
```
user: root 
password: root
```
#MySQL for zabbix
```
DB_NAME: zabbix
DB_USER: zabbix
DB_PASS: zabbix
```
# SSH
```
ssh -p1022 root@localhost
password: root
```

# NGINX server config file for communicate with docker
```
server {
        listen *:80;
        server_name localhost;
        proxy_set_header Host localhost;
        client_max_body_size 100M;

                location / {
                                proxy_set_header Host $host;
                                proxy_set_header X-Real-IP $remote_addr;
                                proxy_cache off;
                                proxy_pass http://localhost:1080;
                        }
}
```

# etcKeeper 
Added etcKeeper - autocommit on exit to /etc git local repository

# Origin
[Docker Hub] (https://registry.hub.docker.com/u/cristo/zabbix)

[Git Hub] (https://github.com/monte-fm/zabbix)
