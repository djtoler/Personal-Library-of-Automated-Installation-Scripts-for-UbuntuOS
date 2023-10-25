#!/bin/bash


# Ensure arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Please enter at least 1 module"
    exit 1
fi

# Function to create module directories and files
create_module() {
    local resource="$1"
    
    mkdir -p "modules/$resource"
    touch "modules/$resource/main.tf"
    touch "modules/$resource/variables.tf"
    touch "modules/$resource/outputs.tf"
}

# Iterate over provided arguments and create modules
for resource in "$@"; do
    create_module "$resource"
done

echo "All requested modules have been created."
