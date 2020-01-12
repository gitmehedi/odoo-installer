# File 


#!/bin/bash

SERVER_1=10.46.10.73
SERVER_2=10.46.10.74
USERNAME=root
FILENAME=/etc/pg-mslr/cluster_status.sh
ODOO_CONF=/etc/odoo.conf

S1_OK=0
S2_OK=0


if  grep -F "$SERVER_1" "$ODOO_CONF"
then
   CUR_MASTER=$SERVER_1
elif  grep -F $SERVER_2 $ODOO_CONF
then
   CUR_MASTER=$SERVER_2
fi

NEW_MASTER=$CUR_MASTER

ssh -t $USERNAME@$SERVER_1 $FILENAME
if [ $? == "1" ]
then
  echo $?
 NEW_MASTER=$SERVER_1
fi

ssh -t $USERNAME@$SERVER_2 $FILENAME
if [ $? == "1" ]
then
  echo $?
  NEW_MASTER=$SERVER_2
fi

echo "NEW: $NEW_MASTER"
echo "OLD: $CUR_MASTER"


if [ "$CUR_MASTER" != "$NEW_MASTER" ]
then
  sed -i s/"$CUR_MASTER"/"$NEW_MASTER"/g $ODOO_CONF
  kill -9 $(ps -ef | grep odoo | awk '{print $2}')
  systemctl restart odoo.service
fi
