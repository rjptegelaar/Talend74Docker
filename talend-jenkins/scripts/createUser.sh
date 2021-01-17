#!/bin/bash
echo "Add user."

useradd jenkinsadmin -s /bin/bash -m -g jenkins -G jenkins

echo "jenkinsadmin:password" | chpasswd

echo "Done adding user"