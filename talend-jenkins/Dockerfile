#Centos as base
FROM jenkins/jenkins:lts

#Set Jenkins custom password
ENV JENKINS_ADMIN_USER_PASSWORD replaceme
RUN export JENKINS_ADMIN_USER_PASSWORD

#Install unzip
USER root
RUN apt update
RUN apt-get install -y unzip
RUN apt-get install -y zip
RUN apt-get install -y vim
RUN apt-get install -y dos2unix

USER jenkins

#Open ports
EXPOSE 8080 50000

#Disable setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

#Copy configs to etc
COPY src/main/resources/configs/plugins.txt /usr/share/jenkins/ref/plugins.txt

USER root
#Copy scripts
RUN mkdir /opt/scripts
RUN mkdir /opt/security
RUN mkdir /opt/jobsstaging
RUN mkdir /opt/jobs
RUN mkdir /opt/config

COPY src/main/resources/scripts/createUser.sh /opt/scripts
COPY src/main/resources/scripts/installGroovy.sh /opt/scripts
COPY src/main/resources/scripts/start.sh /opt/scripts
COPY src/main/resources/scripts/parseConfig.sh /opt/scripts
COPY src/main/resources/scripts/setupSecurity.groovy /usr/share/jenkins/ref/init.groovy.d/setupSecurity.groovy
COPY target/jobs.zip /opt/jobsstaging
COPY src/main/resources/configs/defaultconfig.xml /opt/jobsstaging
COPY config/*.cfg /opt/config/

#Correct rights
RUN chmod o+rx -R /opt/scripts
RUN chmod +rx -R /opt/scripts
RUN chmod o+rx -R /usr/share/jenkins/ref/init.groovy.d/
RUN chmod +rx -R /usr/share/jenkins/ref/init.groovy.d/
RUN chgrp jenkins /opt/security
RUN chmod g+rx /opt/security
RUN chmod o+rx -R /opt/jobsstaging
RUN chmod +rx -R /opt/jobsstaging
RUN chmod o+rx -R /opt/config
RUN chmod +rx -R /opt/config
RUN chown -R jenkins:jenkins /opt/jobsstaging
RUN chown -R jenkins:jenkins /opt/jobs
RUN chown -R jenkins:jenkins /opt/config
RUN chown -R jenkins:jenkins /opt/scripts

#Add user
RUN chmod o+r /etc/shadow
RUN chmod o+r /sbin/unix_chkpwd
RUN chmod +r /etc/shadow
RUN chmod +r /sbin/unix_chkpwd
RUN /opt/scripts/createUser.sh

USER jenkins
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENTRYPOINT ["/opt/scripts/start.sh"]