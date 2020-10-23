#Centos as base
FROM centos:7

#Add pwgen
RUN yum -y install epel-release pwgen java-11-openjdk-headless unzip

#Set java home
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
RUN export JAVA_HOME

#Download Talend Open Studio for ESB
RUN curl -sSo /opt/TOS_ESB-20200219_1130-V7.3.1.zip https://download-mirror2.talend.com/esb/release/V7.4.1M3/TOS_ESB-20201015_1726-V7.4.1M3.zip> /dev/null

#Unzip Talend runtime
RUN unzip /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip -d /opt/TOS_ESB-20201015_1726-V7.4.1M3

#Delete Talend runtime zip
RUN rm -rf /opt/TOS_ESB-20201015_1726-V7.4.1M3.zip

#Delete Talend studio
RUN rm -rf /opt/TOS_ESB-20201015_1726-V7.4.1M3/Studio

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