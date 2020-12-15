#!/bin/sh

#Unzip deployment package
unzip /opt/talend.zip -d /opt 2>/dev/null

#Move configs silently
mv /opt/talend/config/*.cfg $TALEND_CONTAINER_HOME/etc 2>/dev/null

#Sleep after configs
sleep 2

#Move jars silently
mv /opt/talend/kars/*.jar $TALEND_CONTAINER_HOME/deploy 2>/dev/null

#Sleep after jars
sleep 2

#Move kars silently
mv /opt/talend/kars/*.kar $TALEND_CONTAINER_HOME/deploy 2>/dev/null