#!/bin/bash

# This script sets up the environment for Netlify or Vercel

# Ensure the correct Node.js version is used
if ! command -v nvm &> /dev/null; then
    echo "NVM not found. Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

nvm install 18
nvm use 18

# Install Foundry and Forge
if ! command -v forge &> /dev/null; then
    echo "Foundry is not installed. Installing..."
    curl -L https://foundry.paradigm.xyz | bash
    source $HOME/.bashrc
    export PATH="$HOME/.foundry/bin:$PATH"
    foundryup
fi

# Install dependencies
pnpm install
