#!/bin/bash
echo "Add user."

useradd jenkinsadmin -s /bin/bash -m -g jenkins -G jenkins  || true

echo "jenkinsadmin:$JENKINS_ADMIN_USER_PASSWORD" | chpasswd

echo "Done adding user"