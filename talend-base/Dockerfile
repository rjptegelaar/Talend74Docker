#Centos as base
FROM opensuse/leap:15.1

#Update repo
RUN zypper --non-interactive refresh

#Add java and unzip
RUN zypper --non-interactive install java-11-openjdk-devel
RUN zypper --non-interactive install unzip

#Set java home
ENV JAVA_HOME /usr/lib64/jvm/java-11-openjdk-11/
RUN export JAVA_HOME

#Put 
COPY TOS_ESB-20201110_1014-V7.4.1M4.zip /opt/

#Unzip Talend runtime
RUN unzip /opt/TOS_ESB-20201110_1014-V7.4.1M4.zip -d /opt/TOS_ESB-20201110_1014-V7.4.1M4

#Set Talend home
ENV TALEND_RUNTIME_HOME /opt/TOS_ESB-20201110_1014-V7.4.1M4
RUN export TALEND_RUNTIME_HOME

#Set Container home
ENV TALEND_CONTAINER_HOME $TALEND_RUNTIME_HOME/Runtime_ESBSE/container
RUN export TALEND_CONTAINER_HOME

#Delete Talend runtime zip
RUN rm -rf /opt/TOS_ESB-20201110_1014-V7.4.1M4.zip

#Correct rights
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/bin/
RUN chmod +rx -R $TALEND_CONTAINER_HOME/bin/