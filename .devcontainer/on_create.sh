#!/bin/bash
# Stop on the first sign of trouble
set -e

# Update the system
apt-get update

# Install Git and other utilities
apt-get install -y git vim curl wget unzip

# Install other software that might be useful in a development context
# For example, build tools, Python, and pip
apt-get install -y build-essential python3 python3-pip

# Clean up the cache to reduce layer size
apt-get clean
rm -rf /var/lib/apt/lists/*
