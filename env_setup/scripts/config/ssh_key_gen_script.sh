#!/bin/bash

# ssh_key_gen_script.sh
# Script to generate a new SSH key and add it to the ssh-agent

# Ask for the user's email
read -p "Enter your passphrase for the SSH key: " passphrase

# Read configuration from the YAML file
email=$(yq e '.email' "$config_file")
algorithm=$(yq e '.ssh.algorithm' "$config_file")
key_size=$(yq e '.ssh.key_size' "$config_file")

# Generate the SSH key
if [ "$algorithm" = "ed25519" ]; then
    ssh-keygen -t $algorithm -C "$email" -N "$passphrase"
else
    ssh-keygen -t $algorithm -b $key_size -C "$email" -N "$passphrase"
fi

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the SSH key to the ssh-agent
if [ "$key_type" = "ed25519" ]; then
    ssh-add ~/.ssh/id_ed25519
else
    ssh-add ~/.ssh/id_rsa
fi


echo "SSH key generated and added to ssh-agent."
