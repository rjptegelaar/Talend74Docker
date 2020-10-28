#Centos as base
FROM centos:7

#Update yum repo
RUN yum -y update

#Add pwgen, java and unzip
RUN yum -y install epel-release pwgen java-11-openjdk-headless unzip

#Clean yum repo after update
RUN yum -y clean all 

#Set java home
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
RUN export JAVA_HOME

#Put 
COPY TOS_ESB-20201015_1726-V7.4.1M3.zip /opt/

#Unzip Talend runtime
RUN unzip /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip -d /opt/TOS_ESB-20201015_1726-V7.4.1M3

#Delete Talend runtime zip
RUN rm -rf /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip

#Correct rights
RUN chmod o+rx -R /opt/TOS_ESB-20201015_1726-V7.4.1M3/Runtime_ESBSE/container/bin/
RUN chmod +rx -R /opt/TOS_ESB-20201015_1726-V7.4.1M3/Runtime_ESBSE/container/bin/

#Set new passwords
RUN export NEWPASS_KARAF=`pwgen -Bs1 36`
RUN export NEWPASS_TADMIN=`pwgen -Bs1 36`
RUN export NEWPASS_TESB=`pwgen -Bs1 36`
RUN sed -ir "s/^[#]*\s*tadmin=.*/tadmin=$NEWPASS_TADMIN,_g_:admingroup,sl_admin/" /opt/TOS_ESB-20201015_1726-V7.4.1M3/Runtime_ESBSE/container/etc/users.properties
RUN sed -ir "s/^[#]*\s*karaf=.*/karaf = $NEWPASS_KARAF,_g_:admingroup/" /opt/TOS_ESB-20201015_1726-V7.4.1M3/Runtime_ESBSE/container/etc/users.properties
RUN sed -ir "s/^[#]*\s*tesb=.*/tesb=$NEWPASS_TESB,_g_:admingroup,sl_maintain/" /opt/TOS_ESB-20201015_1726-V7.4.1M3/Runtime_ESBSE/container/etc/users.properties