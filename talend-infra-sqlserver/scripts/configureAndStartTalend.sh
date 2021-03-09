#!/bin/sh
echo "Start as daemon."
cd $TALEND_CONTAINER_HOME/bin/ 
./trun daemon &
echo "Done starting as deamon, wait a half of a minute for start to complete."
sleep 30
echo "Done starting, configure and stop."
sshpass -p "tadmin" ssh -o StrictHostKeyChecking=no tadmin@localhost -p 8101 "source scripts/addUsers.sh" &
sleep 10
echo "Done adding users, configure infrastructure"
sshpass -p $TALEND_ADMIN_USER_PASSWORD ssh -o StrictHostKeyChecking=no talendadmin@localhost -p 8101 "source scripts/configureInfrastructureServices.sh" &
sleep 30
echo "Done starting infra."
./trun stop
sleep 30
echo "Stopped."
echo "Randomize passwords"
sed -i "s/^[#]*\s*tadmin=.*/tadmin=`pwgen -Bs1 36`,_g_:admingroup,sl_admin,ssh/" $TALEND_CONTAINER_HOME/etc/users.properties
sed -i "s/^[#]*\s*karaf =.*/karaf = `pwgen -Bs1 36`,_g_:admingroup/" $TALEND_CONTAINER_HOME/etc/users.properties
sed -i "s/^[#]*\s*tesb=.*/tesb=`pwgen -Bs1 36`,_g_:admingroup,sl_maintain/" $TALEND_CONTAINER_HOME/etc/users.properties
echo "Start runtime."
./trun run