#
#
# Copyright (C) 2011-2019 Talend Inc.
# %%
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This is NOT a OS shell script, but a Karaf script
# To execute it, open a Karaf shell for your container and type: source scripts/<This script's name>

echo "Connect to Infrastructure Runtime Server"


echo
echo "Change SAM configuration (Pid: org.talend.esb.sam.agent.cfg)"
config:edit --force org.talend.esb.sam.agent
echo "service.url = http://$sam.host:8040/services/MonitoringServiceSOAP"
config:property-set service.url http://$sam.host:8040/services/MonitoringServiceSOAP
echo "service.authentication=BASIC"
config:property-set service.authentication BASIC
echo "service.security.username=samuser"
config:property-set service.security.username samuser
echo "service.security.password=$talend.sam.user.password"
config:property-set service.security.password $talend.sam.user.password
config:update



# Talend ESB Studio needs to read the ending tag on initializing, please do not remove it.
echo "EOF"
