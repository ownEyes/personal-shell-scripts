#!/bin/bash

# ros_install.sh
# Script to install ROS

# Read ROS distribution and dependencies from the config file
# Read ROS distribution from the config file
ROS_DISTRIBUTION=$(sudo yq e '.ros.distribution' "$config_file")
ROS_DEPENDENCIES=$(yq e '.ros.dependencies[]' "$config_file")

# Check if ROS distribution is provided
if [ -z "$ROS_DISTRIBUTION" ]; then
    echo "ROS distribution not specified in config.yaml."
    exit 1
fi

# Check for existing ROS installation
if [ -d "/opt/ros/$ROS_DISTRIBUTION" ]; then
    echo "An existing ROS $ROS_DISTRIBUTION installation was found."
    read -p "Do you want to continue with the installation? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation aborted."
        exit 1
    fi
fi

echo "Installing ROS $ROS_DISTRIBUTION..."

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please installing curl..."
    sudo apt-get install -y curl
fi

# Setup sources and keys (Ubuntu-based distributions)
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Update package index
sudo apt-get update

# Install ROS distribution
sudo apt-get install -y "ros-$ROS_DISTRIBUTION-desktop-full"

# Check if there are any additional dependencies to install
if [ -n "$ROS_DEPENDENCIES" ]; then
    echo "Installing additional ROS dependencies..."
    for pkg in $ROS_DEPENDENCIES; do
        echo "Installing $pkg..."
        sudo apt-get install -y "$pkg"
    done
else
    echo "No additional ROS dependencies specified in config.yaml."
fi

# Initialize rosdep
sudo rosdep init
rosdep update

# Environment setup
echo "source /opt/ros/$ROS_DISTRIBUTION/setup.bash" >> ~/.bashrc

echo "ROS $ROS_DISTRIBUTION installation completed."