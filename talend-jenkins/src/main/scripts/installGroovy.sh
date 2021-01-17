#!/bin/bash
echo "Start install Groovy."

curl -s get.sdkman.io | bash
sleep 10
source "$HOME/.sdkman/bin/sdkman-init.sh"
sleep 10
sdk install groovy

echo "Done installing Groovy"