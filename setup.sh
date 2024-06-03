#!/bin/bash

# This script sets up the environment for Netlify

# Ensure coreutils is installed to provide mkdir and other essential commands
if ! command -v mkdir &> /dev/null; then
    echo "coreutils is not installed. Installing..."
    apt-get update && apt-get install -y coreutils
fi

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
