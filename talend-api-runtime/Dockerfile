#Talend 7.4 connected runtime
FROM paultegelaar/talend74runtime:20201110_1014-V7.4.1M4

#Set container ports
ENV CONTAINER_PORTS_SCRIPT configureC1.sh
RUN export CONTAINER_PORTS_SCRIPT

ENV CONTAINER_COMMAND_PORT 8102
RUN export CONTAINER_COMMAND_PORT

#Switch ports
RUN /opt/scripts/startAndSwitchPorts.sh

#Start Talend Runtime
ENTRYPOINT ["bash","/opt/scripts/configureAndStartTalend.sh"]