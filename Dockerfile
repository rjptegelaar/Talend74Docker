#Centos as base
FROM centos:8

#Open ports
EXPOSE 8040 8101 9001

#Update yum repo
RUN yum -y update

#Add pwgen, java and unzip
RUN yum -y install java-11-openjdk-devel
RUN yum -y install unzip
RUN yum -y install epel-release
RUN yum -y install pwgen 


#Clean yum repo after update
RUN yum -y clean all 

#Set java home
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
RUN export JAVA_HOME

#Put 
COPY TOS_ESB-20201015_1726-V7.4.1M3.zip /opt/

#Unzip Talend runtime
RUN unzip /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip -d /opt/TOS_ESB-20201015_1726-V7.4.1M3

#Set Talend home
ENV TALEND_RUNTIME_HOME /opt/TOS_ESB-20201015_1726-V7.4.1M3
RUN export TALEND_RUNTIME_HOME

#Set Container home
ENV TALEND_CONTAINER_HOME $TALEND_RUNTIME_HOME/Runtime_ESBSE/container
RUN export TALEND_CONTAINER_HOME

#Delete Talend runtime zip
RUN rm -rf /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip

#Correct rights
RUN chmod o+rx -R $TALEND_CONTAINER_HOME/bin/
RUN chmod +rx -R $TALEND_CONTAINER_HOME/bin/