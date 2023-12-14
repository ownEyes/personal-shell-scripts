#!/bin/bash

# yq_install.sh
# Script to check the installation status of yq

# Check if yq is installed

if ! command -v yq &> /dev/null
then
    echo "yq is not installed. Installing yq..."
    sudo apt install yq -y
else
    echo "yq is already installed."
fi