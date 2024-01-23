#!/bin/bash

# ros_install.sh
# Script to install ROS

# Set font name and download URL
FONT_NAME=$(sudo yq e '.nerdFont.font_name' "$config_file")
GITHUB_REPO=$(sudo yq e '.nerdFont.github_repo' "$config_file")
RELEASE_URL="https://github.com/${GITHUB_REPO}/releases/latest/download/${FONT_NAME}.zip"

# Create a temporary directory for the font download
TMP_DIR=$(mktemp -d)
echo "Created temporary directory: ${TMP_DIR}"

# Navigate to the temporary directory
cd "$TMP_DIR"

# Download the font
echo "Downloading ${FONT_NAME} Nerd Font..."
wget -q --show-progress "$RELEASE_URL" -O "${FONT_NAME}.zip"

# Create the ~/.fonts directory if it doesn't exist
mkdir -p ~/.fonts

# Unzip the font to ~/.fonts
echo "Installing the font to ~/.fonts"
unzip -q "${FONT_NAME}.zip" -d ~/.fonts

# Clean up temporary files
rm -rf "$TMP_DIR"

# Update the font cache
echo "Updating font cache..."
fc-cache -fv ~/.fonts

# Print completion message with color
echo -e "\e[32mFont installed successfully. Please manually change your terminal font to ${FONT_NAME}.\e[0m"