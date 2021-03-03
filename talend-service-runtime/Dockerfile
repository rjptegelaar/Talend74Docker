#Talend 7.4 connected runtime
FROM paultegelaar/talend74runtime:20210107_1111-V7.4.1M6	

#Set container ports
ENV CONTAINER_PORTS_SCRIPT configureC1.sh
RUN export CONTAINER_PORTS_SCRIPT

ENV CONTAINER_COMMAND_PORT 8102
RUN export CONTAINER_COMMAND_PORT

#Copy deployment
COPY target/talend.zip /opt

#Switch ports
RUN /opt/scripts/startAndSwitchPorts.sh

#Start Talend Runtime
ENTRYPOINT ["bash","/opt/scripts/configureAndStartTalend.sh"]