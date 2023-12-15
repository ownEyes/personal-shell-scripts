#!/bin/bash



# Install Vim

if ! dpkg -l | grep -qw vim; then

    echo "Vim is not installed. Installing..."

    sudo apt-get update

    sudo apt-get install vim -y

else

    echo "Vim is already installed."

fi

# Check and remove Firefox (APT and Snap versions)

if dpkg -l | grep -qw firefox || snap list | grep -qw firefox; then

    echo "Firefox is installed. Uninstalling..."

    sudo apt-get remove --purge firefox -y

    sudo snap remove firefox

else

    echo "Firefox is not installed."

fi

# Install Microsoft Edge

if ! dpkg -l | grep -qw microsoft-edge-stable; then

    echo "Microsoft Edge is not installed. Installing..."

    EDGE_URL=$(wget -qO- https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/ | grep -oP 'href="\K(microsoft-edge-stable_[^"]*.deb)' | sort -V | tail -n1)

    wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/$EDGE_URL

    sudo dpkg -i $EDGE_URL

    rm $EDGE_URL

else

    echo "Microsoft Edge is already installed."

fi

# Install VSCode

if ! dpkg -l | grep -i -qw ' code '; then

    echo "Visual Studio Code is not installed. Installing..."

    VSCODE_URL=$(wget -qO- https://packages.microsoft.com/repos/code/pool/main/c/code/ | grep -oP 'href="\K(code_[^"]*.deb)' | sort -V | tail -n1)

    wget "https://packages.microsoft.com/repos/code/pool/main/c/code/$VSCODE_URL" -O $VSCODE_URL

    sudo dpkg -i $VSCODE_URL

    rm $VSCODE_URL

else

    echo "Visual Studio Code is already installed."

fi

echo "Script execution completed."

