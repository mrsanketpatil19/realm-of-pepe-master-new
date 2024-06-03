#!/bin/bash

# This script sets up the environment for Netlify

# Update system packages
apt-get update && apt-get upgrade -y

# Install missing packages
apt-get install -y coreutils procps

# Install Foundry and Forge
if ! command -v forge &> /dev/null; then
    echo "Foundry is not installed. Installing..."
    curl -L https://foundry.paradigm.xyz | bash
    source $HOME/.bashrc
    export PATH="$HOME/.foundry/bin:$PATH"
    foundryup
fi

# Ensure the correct Node.js version is used
if [ "$(node -v)" != "v18" ]; then
    echo "Switching to Node.js v18..."
    nvm install 18
    nvm use 18
fi

# Install dependencies
pnpm install
