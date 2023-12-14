#! /bin/bash

# install.sh
# Master script to initiate the setup
echo "Installing packages..."

sudo apt update

echo "Starting environment setup..."

export current_dir=$(dirname "$(realpath "$0")")
export config_file="${current_dir}/config.yaml"

find "${current_dir}" -type f -name "*.sh" -exec chmod +x {} \;

"${current_dir}/scripts/installation/yq_install.sh"
# Call the Git configuration Script
# "${current_dir}/scripts/config/git_config.sh"

# Iterate over each argument
for arg in "$@"
do
    case $arg in
        git)
            echo "Configuring Git..."
            "${current_dir}/scripts/config/git_config.sh"
            ;;
        conda)
            echo "Configuring Conda..."
            # Call a Conda configuration script here (if you have one)
            "${current_dir}/scripts/Installation/conda_install.sh"
            ;;
        *)
            echo "Unknown argument: $arg"
            ;;
    esac
done


echo "Environment setup completed."
