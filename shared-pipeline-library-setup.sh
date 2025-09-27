#!/bin/bash

# Check if the directory exists
if [[ ! -d "$1" ]]; then
  echo "Please provide an existing directory"
  exit 1
fi

# Process all secrets from the specified directory
for secret_file in "$1"/*; do
  if [[ -f "$secret_file" ]]; then
    # Get the filename (env var name) and convert to lowercase for output
    env_var_name=$(basename "$secret_file")
    output_name=$(echo "$env_var_name" | tr '[:upper:]' '[:lower:]')
    
    # Read the secret value
    secret_value=$(cat "$secret_file")
    
    # Mask the secret (mask each line for multi-line secrets)
    while IFS= read -r line; do
      echo "::add-mask::$line"
    done <<< "$secret_value"
    
    # Set output using EOF syntax for multi-line support
    {
      echo "${output_name}<<EOF"
      echo "$secret_value"
      echo "EOF"
    } >> "$GITHUB_OUTPUT"
  fi
done
