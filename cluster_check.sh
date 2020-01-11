#!/bin/bash
  
SERVER_1=192.168.56.103
SERVER_2=192.168.56.104
USERNAME=node
FILENAME=/var/lib/postgresql/10/replication/recovery.conf
ODOO_CONF=/Users/beast/software/odoo/conf/mtb_dev.conf
#ODOO_CONF=/opt/odoo/server/conf/10.0/mtb_dev.conf

S1_OK=0
S2_OK=0

if  grep -F "$SERVER_1" "$ODOO_CONF"
then
   CUR_MASTER=$SERVER_1
elif  grep -F $SERVER_2 $ODOO_CONF
then
   CUR_MASTER=$SERVER_2
fi

ssh $USERNAME@$SERVER_1  test -f  $FILENAME && ((S1_OK++))
if [ $S1_OK == 1 ]
then
 NEW_MASTER=$SERVER_1
fi

ssh $USERNAME@$SERVER_2  test -f  $FILENAME && ((S2_OK++))
if [ $S2_OK == 1 ]
then
 NEW_MASTER=$SERVER_2
fi

echo -e "$CUR_MASTER == $NEW_MASTER"
if [ "$CUR_MASTER" != "$NEW_MASTER" ]
then
 sed -i s/"$CUR_MASTER"/"$NEW_MASTER "/g $ODOO_CONF
 kill -9 $(ps -ef | grep odoo | awk '{print $2}')
 /Users/beast/software/odoo/server/10.0/odoo-bin -c $ODOO_CONF
fi


## After Edit File

#!/bin/bash

SERVER_1=192.168.56.103
SERVER_2=192.168.56.104
USERNAME=node
FILENAME=/home/node/check_cluster.sh
ODOO_CONF=/Users/beast/software/odoo/conf/mtb_dev.conf
#ODOO_CONF=/opt/odoo/server/conf/10.0/mtb_dev.conf

S1_OK=0
S2_OK=0


if  grep -F "$SERVER_1" "$ODOO_CONF"
then
   CUR_MASTER=$SERVER_1
elif  grep -F $SERVER_2 $ODOO_CONF
then
   CUR_MASTER=$SERVER_2
fi


NODE_1=`ssh -t $USERNAME@$SERVER_1 $FILENAME`
#echo $NODE_1
#ssh $USERNAME@$SERVER_1  test -f  $FILENAME && ((S1_OK++))
if [ $NODE_1 == 'master' ]
then
 NEW_MASTER=$SERVER_1
fi

NODE_2=`ssh -t $USERNAME@$SERVER_2 $FILENAME`

#ssh $USERNAME@$SERVER_2  test -f  $FILENAME && ((S2_OK++))
if [ $NODE_2 == 'slave' ]
then
 NEW_MASTER=$SERVER_2
fi

echo -e "$CUR_MASTER == $NODE_1 == $NODE_2"
echo $NODE_1
echo $NODE_2
if [ "$CUR_MASTER" != "$NODE_1" ]
then
  sed -i s/"$CUR_MASTER"/"$NODE_1 "/g $ODOO_CONF
  kill -9 $(ps -ef | grep odoo | awk '{print $2}')
  /Users/beast/software/odoo/server/10.0/odoo-bin -c $ODOO_CONF
elif [ "$CUR_MASTER" != "$NODE_2" ]; then
   sed -i s/"$CUR_MASTER"/"$NODE_2 "/g $ODOO_CONF
  kill -9 $(ps -ef | grep odoo | awk '{print $2}')
  /Users/beast/software/odoo/server/10.0/odoo-bin -c $ODOO_CONF
fi





## In PG Server

#!/bin/bash
RESULTS=`sudo -u postgres -H -- psql -d postgres -c "SELECT pg_is_in_recovery FROM pg_is_in_recovery()"`

if [[ $RESULTS =~ "f" ]]
then
	echo "master"
elif [[ $RESULTS =~ "t" ]]
then
	echo "slave"
else
	echo "Please configure database properly."
fi



#!/bin/bash

SERVER_1=192.168.56.103
SERVER_2=192.168.56.104
USERNAME=node
FILENAME=/home/node/check_cluster.sh
ODOO_CONF=/Users/beast/software/odoo/conf/mtb_dev.conf
#ODOO_CONF=/opt/odoo/server/conf/10.0/mtb_dev.conf

S1_OK=0
S2_OK=0


if  grep -F "$SERVER_1" "$ODOO_CONF"
then
   CUR_MASTER=$SERVER_1
elif  grep -F $SERVER_2 $ODOO_CONF
then
   CUR_MASTER=$SERVER_2
fi


ssh -t $USERNAME@$SERVER_1 $FILENAME
#ssh $USERNAME@$SERVER_1  test -f  $FILENAME && ((S1_OK++))
if [ $? == 1 ]
then
  echo $?
 NEW_MASTER=$SERVER_1
fi

ssh -t $USERNAME@$SERVER_2 $FILENAME

#ssh $USERNAME@$SERVER_2  test -f  $FILENAME && ((S2_OK++))
if [ $? == 1 ]
then
 NEW_MASTER=$SERVER_2
fi

echo -e "$CUR_MASTER == $NEW_MASTER"
echo $NODE_1
echo $NODE_2
if [ -z $NEW_MASTER ] && [ "$CUR_MASTER" != "$NEW_MASTER" ]
then
  sed -i s/"$CUR_MASTER"/"$NEW_MASTER"/g $ODOO_CONF
  kill -9 $(ps -ef | grep odoo | awk '{print $2}')
  /Users/beast/software/odoo/server/10.0/odoo-bin -c $ODOO_CONF
fi

