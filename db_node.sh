# Main location of file is 
$ mkdir -p /etc/pg-mslr

# Create a file for cluster_status.sh
$ touch /etc/pg-mslr/cluster_status.sh
# Content of file

#!/bin/bash

RESULTS=`sudo -i -u postgres psql -c "select pg_is_in_recovery()"`
if [[ $RESULTS =~ "f" ]]
then
        exit 1
elif [[ $RESULTS =~ "t" ]]
then
        exit 2
else
        exit 0
fi


# Create a file for healthcheck.sh
$ touch /etc/pg-mslr/healthcheck.sh
# Content of file

#!/bin/bash

CLUSTER_IP=10.46.10.74

RECOVERY=/var/lib/pgsql/10/replication/recovery.conf
FILE=$RECOVERY
FILENAME=/etc/pg-mslr/cluster_status.sh

ssh -t root@$CLUSTER_IP $FILENAME

if [ $? == "1" ]; then
 bash /etc/pg-mslr/replication.sh $CLUSTER_IP
 systemctl start pg-stm.service

 COUNT=0
 while true;
   do
     STATE=$(/usr/pgsql-10/bin/pg_isready -h $CLUSTER_IP -p 5432 | awk '/accepting/{print $0}')
     CHECK=${#STATE}

     if [ $CHECK -eq 0 ]
       then
          COUNT=$((COUNT + 1))
     else
         COUNT=0
     fi

     echo $COUNT

     if [ $COUNT -eq 15 ]
       then
         systemctl stop postgresql-10.service
         mv $RECOVERY  ~/
         systemctl start postgresql-10.service
         exit 0
     fi
    sleep 1
 done
else
 systemctl start postgresql-10.service
 systemctl stop pg-stm.service
fi

# Create a file for pg-check.sh
$ touch /etc/pg-mslr/pg-check.sh
# Content of file

#!/bin/bash

if [ $1 == "start" ]
then
  bash /etc/pg-mslr/healthcheck.sh
fi

# Create a file for replication.sh
$ touch /etc/pg-mslr/replication.sh
# Content of file


#!/bin/bash

#echo -e "Master Server IP (EX: 10.45.10.73): "
MASTER_IP=$1
SLAVE=/var/lib/pgsql/10/replication


if [ -d $SLAVE ]
then
  echo "exits"
  rm -rf $SLAVE
fi

systemctl stop postgresql-10.service
PGPASSWORD=Mtb1234 pg_basebackup -h $MASTER_IP -D $SLAVE -P -U odoo --wal-method=stream
chown -R postgres:postgres $SLAVE

echo "
standby_mode = 'on'
primary_conninfo = 'host=$MASTER_IP port=5432 user=odoo password=Mtb1234'
restore_command = 'cp /var/lib/pgsql/10/data/archive/%f %p'
trigger_file = '/tmp/postgresql.trigger.5432'
" >> "${SLAVE}/recovery.conf"

systemctl start postgresql-10.service






