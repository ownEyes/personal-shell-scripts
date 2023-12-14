#!/bin/bash

# git_install.sh
# Script to check the installation status of Git

# Check if Git is installed

# command is a shell built-in command that performs a specific function, 
# in this case, -v (which stands for "verbose").
# When used with command -v, 
# it returns the path to the executable of the specified command (here, git) 
# if it exists in the user's $PATH.
# If Git is installed and accessible in the system's path, 
# command -v git will output the path to the Git executable; if not, it will produce no output and return a non-zero exit status.
# &> is a redirection operator in Bash. 
# It redirects both the standard output (stdout) and the standard error (stderr) to the specified location.

if ! command -v git &> /dev/null
then
    echo "Git is not installed. Installing Git..."
    sudo apt install git -y
else
    echo "Git is already installed."
fi