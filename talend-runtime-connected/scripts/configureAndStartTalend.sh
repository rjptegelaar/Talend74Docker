#!/bin/sh

echo "Delay start for nr of seconds: $START_DELAY"
sleep $START_DELAY

if [ ! -f "/opt/configured" ]; then

echo "Configuring Container."
echo "Start as daemon."
cd $TALEND_CONTAINER_HOME/bin/ 
./trun daemon &
echo "Done starting as deamon, wait a half of a minute for start to complete."
sleep 30
echo "Done starting, configure and stop."
sshpass -p "tadmin" ssh -o StrictHostKeyChecking=no tadmin@localhost -p $CONTAINER_COMMAND_PORT "source scripts/addUsers.sh" &
sleep 10
echo "Done adding users."
echo "Configure SAM connection."
sshpass -p $TALEND_ADMIN_USER_PASSWORD ssh -o StrictHostKeyChecking=no talendadmin@localhost -p $CONTAINER_COMMAND_PORT "source scripts/configureSAM.sh" &
sleep 10
echo "Configured SAM connection."
sleep 10
echo "Configure Locator connection."
sshpass -p $TALEND_ADMIN_USER_PASSWORD ssh -o StrictHostKeyChecking=no talendadmin@localhost -p $CONTAINER_COMMAND_PORT "source scripts/configureLocator.sh" &
sleep 10
echo "Configured Locator connection."
echo "Stopping runtime"
./trun stop
sleep 30
echo "Stopped."
echo "Deploying Talend logic."
/opt/scripts/copyConfigsAndKars.sh
echo "Deployed Talend logic."
echo "Randomize passwords"
sed -i "s/^[#]*\s*tadmin=.*/tadmin=`pwgen -Bs1 36`,_g_:admingroup,sl_admin,ssh/" $TALEND_CONTAINER_HOME/etc/users.properties
sed -i "s/^[#]*\s*karaf =.*/karaf = `pwgen -Bs1 36`,_g_:admingroup/" $TALEND_CONTAINER_HOME/etc/users.properties
sed -i "s/^[#]*\s*tesb=.*/tesb=`pwgen -Bs1 36`,_g_:admingroup,sl_maintain/" $TALEND_CONTAINER_HOME/etc/users.properties

touch /opt/configured
else 
    echo "Container already configured"
fi

echo "Start runtime."
./trun run