#!/bin/sh
sleep 30
echo "Start as daemon."
cd $TALEND_CONTAINER_HOME/bin/ 
./trun daemon &
echo "Done starting as deamon, wait a half of a minute for start to complete."
sleep 30
echo "Done starting, configure and stop."
echo "Configure ports."
sshpass -p tadmin ssh -o StrictHostKeyChecking=no tadmin@localhost -p 8101 "source scripts/$CONTAINER_PORTS_SCRIPT"
echo "Configured ports."
sleep 5
./trun stop
sleep 30
echo "Stopped."