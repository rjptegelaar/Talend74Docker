#Talend 7.4 base
FROM paultegelaar/talend74base:20210107_1111-V7.4.1M6

#Open ports
EXPOSE 8040 9001 2181

#Set SQL server variables
ENV SQL_SERVER_HOST replaceme
RUN export SQL_SERVER_HOST

ENV SQL_SERVER_PORT 1433
RUN export SQL_SERVER_PORT

ENV SQL_SERVER_DBNAME replaceme
RUN export SQL_SERVER_DBNAME

ENV SQL_SERVER_USER replaceme
RUN export SQL_SERVER_USER

ENV SQL_SERVER_PASSWORD replaceme
RUN export SQL_SERVER_PASSWORD

#Set Talend custom passwords
ENV TALEND_SAM_USER_PASSWORD replaceme
RUN export TALEND_SAM_USER_PASSWORD

ENV TALEND_ADMIN_USER_PASSWORD replaceme
RUN export TALEND_ADMIN_USER_PASSWORD


#Install SSH
RUN zypper --non-interactive install pwgen
RUN zypper --non-interactive install openssh
RUN zypper --non-interactive install sshpass

#Copy deps
COPY target/talend-deps.zip /opt

#Unzip Talend deps
RUN unzip /opt/talend-deps.zip -d /opt

#Move libs to deploy
RUN mv /opt/talend-deps/lib/*.jar $TALEND_CONTAINER_HOME/deploy

#Copy configs to etc
COPY configs/users.properties $TALEND_CONTAINER_HOME/etc

#Delete Talend deps
RUN rm -rf /opt/talend-deps.zip
RUN rm -rf /opt/talend-deps

#Copy scripts
RUN mkdir /opt/scripts
COPY scripts/configureInfrastructureServices.sh $TALEND_CONTAINER_HOME/scripts
COPY scripts/addUsers.sh $TALEND_CONTAINER_HOME/scripts
COPY scripts/configureAndStartTalend.sh /opt/scripts
COPY scripts/wait-centos.sh /opt/scripts
COPY scripts/setenv $TALEND_CONTAINER_HOME/bin


#Correct rights
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/scripts
RUN chmod +rx -R $TALEND_CONTAINER_HOME/scripts
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/bin
RUN chmod +rx -R $TALEND_CONTAINER_HOME/bin
RUN chmod o+rx -R /opt/scripts
RUN chmod +rx -R /opt/scripts

#Start Talend Runtime
ENTRYPOINT ["bash","/opt/scripts/configureAndStartTalend.sh"]