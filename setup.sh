#!/bin/bash
# This script sets up the environment for Netlify

# Install Foundry and Forge
if ! command -v forge &> /dev/null
then
    echo "Foundry is not installed. Installing..."
    curl -L https://foundry.paradigm.xyz | bash
    source ~/.bashrc
    foundryup
fi

# Install dependencies
pnpm install
