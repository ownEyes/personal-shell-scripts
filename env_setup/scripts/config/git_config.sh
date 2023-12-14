#!/bin/bash

# git_config.sh
# Script to configure Git settings

# Check for existing SSH keys
# redirections 1> /dev/null 2>&1 ensure that the output and any errors are suppressed.
echo "Checking for existing SSH keys..."
if ls -al ~/.ssh/*.pub 1> /dev/null 2>&1; then
    echo "You have existing SSH public keys:"
    ls -al ~/.ssh/*.pub

    # Let user choose an SSH key
    echo "Which SSH key would you like to use for GitHub? (Enter the filename)"
    read ssh_key_filename

    # Display the chosen SSH key
    echo "Selected SSH key:"
    cat ~/.ssh/"$ssh_key_filename"

else
    echo "No SSH keys found. Generating a new SSH key..."

    # Call SSH key generation script
    "${current_dir}/config/ssh_key_gen_script.sh"
fi

# Check if .gitconfig exists in the user's home directory
git_config_file="$HOME/.gitconfig"
if [ -f "$git_config_file" ]; then
    echo ".gitconfig exists in the home directory."

    # Extract and echo the Git user name and email
    git_user_name=$(git config --global user.name)
    git_user_email=$(git config --global user.email)
    echo "Git user name: $git_user_name"
    echo "Git user email: $git_user_email"
else
    echo ".gitconfig does not exist in the home directory."
    # Copy the Git config template to the user's home directory
    cp "${current_dir}/templates/.gitconfig" ~/

    git_user_name=$(yq e '.git_user_name' "$config_file")
    git_user_email=$(yq e '.git_user_email' "$config_file")

    # Set global user name and email using the provided input
    git config --global user.name "$git_user_name"
    git config --global user.email "$git_user_email"

    echo "Git user name and email have been set."
    # Any other global Git configurations can be added here
    # For example, setting the default branch name:
    # git config --global init.defaultBranch main
fi

echo "Git has been configured."
