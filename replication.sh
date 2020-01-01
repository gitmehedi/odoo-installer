
#!/bin/bash

echo -e "Master Server IP (EX: 10.45.10.73): "
read MASTER_IP

systemctl stop postgresql-10.service

rm -rf /var/lib/pgsql/10/replication/

pg_basebackup -h $MASTER_IP  -D /var/lib/pgsql/10/replication/ -P -U odoo --wal-method=stream
chown -R postgres:postgres /var/lib/pgsql/10/replication/

echo "
standby_mode = 'on'
primary_conninfo = 'host=$MASTER_IP port=5432 user=odoo password=Mtb1234'
restore_command = 'cp /var/lib/pgsql/10/data/archive/%f %p'
trigger_file = '/tmp/postgresql.trigger.5432'
" >> /var/lib/pgsql/10/replication/recovery.conf

systemctl start postgresql-10.service
