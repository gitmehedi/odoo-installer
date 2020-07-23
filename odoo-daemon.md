## Write bash script for odoo daemon in location /etc/odoo.sh 
```
#!/bin/sh

if [ $1 == "start" ]
then
  sudo -u odoo /opt/odoo/server/odoo-bin --config=/etc/odoo.conf
fi

if [ $1 == "stop" ]
then
 kill -9 $(ps -ef | grep odoo | awk '{print $2}')
fi
```

## Write systemd file in location /usr/lib/systemd/system/odoo.service

```
[Unit]
Description=OGL Application

[Service]
ExecStart=/etc/odoo.sh start
ExecStop=/etc/odoo.sh stop


[Install]
WantedBy=multi-user.target
```




