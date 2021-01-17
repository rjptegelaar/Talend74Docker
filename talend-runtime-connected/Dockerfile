#Talend 7.4 base
FROM paultegelaar/talend74base:20201110_1014-V7.4.1M4

#Install SSH
RUN zypper --non-interactive install pwgen
RUN zypper --non-interactive install openssh
RUN zypper --non-interactive install sshpass


#Set Talend custom passwords
ENV TALEND_SAM_USER_PASSWORD replaceme
RUN export TALEND_SAM_USER_PASSWORD

ENV TALEND_ADMIN_USER_PASSWORD replaceme
RUN export TALEND_ADMIN_USER_PASSWORD

ENV TALEND_ESB_USER_PASSWORD replaceme
RUN export TALEND_ESB_USER_PASSWORD

#Set hostnames
ENV LOCATOR_HOST replaceme
RUN export LOCATOR_HOST

ENV EXTERNAL_ADDRESS replaceme
RUN export EXTERNAL_ADDRESS

ENV SAM_HOST replaceme
RUN export SAM_HOST

#Set container ports
ENV CONTAINER_PORTS_SCRIPT configureC3.sh
RUN export CONTAINER_PORTS_SCRIPT

ENV CONTAINER_COMMAND_PORT 8104
RUN export CONTAINER_COMMAND_PORT

#Set start delay
ENV START_DELAY 5
RUN export START_DELAY


#Copy scripts
RUN mkdir /opt/scripts
COPY scripts/configureLocator.sh $TALEND_CONTAINER_HOME/scripts
COPY scripts/configureSAM.sh $TALEND_CONTAINER_HOME/scripts
COPY scripts/addUsers.sh $TALEND_CONTAINER_HOME/scripts
COPY scripts/configureAndStartTalend.sh /opt/scripts
COPY scripts/wait-centos.sh /opt/scripts
COPY scripts/copyConfigsAndKars.sh /opt/scripts
COPY scripts/startAndSwitchPorts.sh /opt/scripts
COPY scripts/setenv $TALEND_CONTAINER_HOME/bin

#Correct rights
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/scripts
RUN chmod +rx -R $TALEND_CONTAINER_HOME/scripts
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/bin
RUN chmod +rx -R $TALEND_CONTAINER_HOME/bin
RUN chmod o+rx -R /opt/scripts
RUN chmod +rx -R /opt/scripts

#Copy configs to etc
COPY configs/users.properties $TALEND_CONTAINER_HOME/etc