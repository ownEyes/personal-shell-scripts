#!/bin/bash

# yq_install.sh
# Script to check the installation status of yq

# Check if yq is installed

if ! command -v yq &> /dev/null
then
    echo "yq is not installed. Installing yq..."
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
    sudo chmod +x /usr/bin/yq
else
    echo "yq is already installed."
fi