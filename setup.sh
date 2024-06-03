#!/bin/bash

# This script sets up the environment for Netlify

# Update system packages
apt-get update && apt-get upgrade -y

# Install missing packages
apt-get install -y coreutils procps

# Install gimme for managing Go versions
curl -sL -o gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
chmod +x gimme
./gimme 1.19

# Set up Go environment
export GOROOT=$HOME/.gimme/versions/go1.19.linux.amd64
export PATH=$GOROOT/bin:$PATH

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
