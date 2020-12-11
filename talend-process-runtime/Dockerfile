#Talend 7.4 connected runtime
FROM paultegelaar/talend74runtime:20201015_1726-V7.4.1M3

#Set container ports
ENV CONTAINER_PORTS_SCRIPT configureC2.sh
RUN export CONTAINER_PORTS_SCRIPT

ENV CONTAINER_COMMAND_PORT 8103
RUN export CONTAINER_COMMAND_PORT

#Switch ports
RUN /opt/scripts/startAndSwitchPorts.sh

#Start Talend Runtime
ENTRYPOINT ["bash","/opt/scripts/configureAndStartTalend.sh"]