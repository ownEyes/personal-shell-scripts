#!/bin/bash

# conda_install.sh
# Script to install Miniconda

# Function to check if a command exists
command_exists() {
    command -v "$@" &> /dev/null
}

# Check if Conda is installed
if command_exists conda; then
    echo "Conda is already installed."
else
    echo "Conda is not installed. Installing Miniconda..."

    # Specify the Miniconda install script URL
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    INSTALL_SCRIPT="Miniconda3-latest-Linux-x86_64.sh"

    # Download the install script
    wget "$MINICONDA_URL" -O "$INSTALL_SCRIPT"

    # Make the install script executable
    chmod +x "$INSTALL_SCRIPT"

    # Run the install script
    ./"$INSTALL_SCRIPT"

    # Optionally, you can automatically initialize Conda by adding a line here:
    # rm "$INSTALL_SCRIPT"  # Clean up the installer script

    # Remove the installer script
    rm "$INSTALL_SCRIPT"

    # Initialize Conda for all supported shells
    "$HOME/miniconda3/bin/conda" init
    
    eval "$($HOME/miniconda3/bin/conda shell.bash hook)"

    echo "Miniconda installation and initialization completed."
fi