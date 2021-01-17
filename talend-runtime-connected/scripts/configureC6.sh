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

HTTP_Port=8046
HTTPS_Port=9007
RMI_Registry_Port=1105
RMI_Server_Port=44450
SSH_Port=8107
COMMAND_SERVER_PORT=8070
FILE_SERVER_PORT=8071
MONITORING_PORT=8948
PROCESS_MESSAGE_PORT=8561

source scripts/configKarafContainer.sh $RMI_Registry_Port $RMI_Server_Port $HTTP_Port $HTTPS_Port $SSH_Port $COMMAND_SERVER_PORT $FILE_SERVER_PORT $MONITORING_PORT $PROCESS_MESSAGE_PORT
