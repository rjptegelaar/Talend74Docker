#!/bin/bash
echo "Creating directories."

echo "Unzip jobs file."
unzip /opt/jobsstaging/jobs.zip -d /opt/jobsstaging/extract

echo "Create Job directories."
ls /opt/jobsstaging/extract/jobs >> /opt/jobsstaging/joblist.txt
while read -r line; do mkdir -p "$JENKINS_HOME/jobs/${line%.zip}" ; done < /opt/jobsstaging/joblist.txt

echo "Copy default config."
while read -r line; do cp /opt/jobsstaging/defaultconfig.xml "$JENKINS_HOME/jobs/${line%.zip}/config.xml" ; done < /opt/jobsstaging/joblist.txt

echo "Unzip job files."
while read -r line; do unzip "/opt/jobsstaging/extract/jobs/$line" -d "/opt/jobs/${line%.zip}" ; done < /opt/jobsstaging/joblist.txt 

echo "Modify configs"
while read -r line; do sed -i "s/\${jobpath}/\/opt\/jobs\/${line%.zip}\/${line%%-*}\/${line%%-*}_run.sh/" "$JENKINS_HOME/jobs/${line%.zip}/config.xml" ; done < /opt/jobsstaging/joblist.txt

echo "Add rights"
chmod o+rx -R /opt/jobs
chmod +rx -R /opt/jobs

echo "Starting Jenkins"

/usr/local/bin/jenkins.sh