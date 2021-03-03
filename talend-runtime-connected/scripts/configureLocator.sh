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
echo "Change locator configuration (Pid: org.talend.esb.locator.cfg)"
config:edit --force org.talend.esb.locator
echo "locator.endpoints=$locator.host:2181"
config:property-set locator.endpoints $locator.host:2181
echo "endpoint.http.prefix http://$external.address:$talend.esb.http.port/services"
config:property-set endpoint.http.prefix https://$external.address:$talend.esb.http.port/services
echo "endpoint.https.prefix=https://$external.address:$talend.esb.https.port/services"
config:property-set endpoint.https.prefix https://$external.address:$talend.esb.https.port/services
config:update


# Talend ESB Studio needs to read the ending tag on initializing, please do not remove it.
echo "EOF"
