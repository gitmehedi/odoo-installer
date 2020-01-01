#!/bin/bash

COUNT=0
while true;
   do
     STATE=$(/usr/pgsql-10/bin/pg_isready -h 10.46.10.73 -p 5432 | awk '/accepting/{print $0}')
     CHECK=${#STATE}
     #echo $STATE $CHECK

     if [ $CHECK -eq 0 ]
       then
          COUNT=$((COUNT + 1))
     else
         COUNT=0
     fi

     echo $COUNT

     if [ $COUNT -eq 20 ]
       then
         systemctl stop postgresql-10.service
         mv /var/lib/pgsql/10/replication/recovery.conf ~/
         systemctl start postgresql-10.service
       exit 0
     fi
    sleep 1
done
