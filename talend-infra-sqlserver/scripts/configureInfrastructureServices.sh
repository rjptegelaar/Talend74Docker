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

echo "Initialize Local Infrastructure Runtime Server"

echo "Install SQL server datasource"
feature:install tesb-datasource-sqlserver
echo "Done installing data source"

echo
echo "Change SQL server configuration (Pid: org.talend.esb.datasource.sqlserver.cfg)"
config:edit --force org.talend.esb.datasource.sqlserver
echo "dataSource.url = jdbc:sqlserver://$sql.server.host:$sql.server.port;databaseName=$sql.server.dbname"
config:property-set dataSource.url jdbc:sqlserver://$sql.server.host:$sql.server.port\;databaseName=$sql.server.dbname
echo "dataSource.user = $sql.server.user"
config:property-set dataSource.user $sql.server.user
echo "dataSource.password = $sql.server.password"
config:property-set dataSource.password $sql.server.password
config:update

echo "Start SAM"
tesb:start-sam
echo "Done starting SAM"

echo
echo "Switch SAM to SQL Server (Pid: org.talend.esb.sam.server.cfg)"
config:edit --force org.talend.esb.sam.server
echo "db.datasource = ds-sqlServer"
config:property-set db.datasource ds-sqlserver
echo "db.dialect = sqlServerDialect"
config:property-set db.dialect sqlServerDialect
config:update

echo
echo "Enable security for SAM (Pid: org.talend.esb.sam.service.rest.cfg)"
config:edit --force org.talend.esb.sam.service.rest
echo "sam.service.rest.authentication = BASIC"
config:property-set sam.service.rest.authentication BASIC
config:update

echo "Enable security for SAM (Pid: org.talend.esb.sam.service.soap.cfg)"
config:edit --force org.talend.esb.sam.service.soap
echo "sam.service.soap.authentication = BASIC"
config:property-set sam.service.soap.authentication BASIC
config:update

echo "Start locator"
tesb:start-locator
echo "Done starting locator"

# Talend ESB Studio needs to read the ending tag on initializing, please do not remove it.
echo "EOF"
