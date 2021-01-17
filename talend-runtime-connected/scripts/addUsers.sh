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

echo "Add relevant extra users"

echo "Select properties realm"
jaas:realm-manage --realm karaf --module org.apache.karaf.jaas.modules.properties.PropertiesLoginModule

echo "Add users"
jaas:user-add talendadmin $talend.admin.user.password
jaas:user-add talendesb $talend.esb.user.password
jaas:user-add samuser $talend.sam.user.password

echo "Add users to groups"
jaas:group-add samuser viewergroup
jaas:group-add talendesb viewergroup
jaas:group-add talendadmin admingroup
jaas:role-add talendadmin ssh

echo "Updating changes"
jaas:update

# Talend ESB Studio needs to read the ending tag on initializing, please do not remove it.
echo "EOF"
