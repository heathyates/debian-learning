# Use the official Ubuntu 22.04 LTS as a base image
FROM ubuntu:22.04

# Set the working directory to /app within the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Ensure the package database is updated and upgrade the system
# This ensures we start with all the latest packages and security patches
RUN apt-get update && apt-get upgrade -y

# Install necessary packages for Debian packaging and Python development
# build-essential: Provides a compilation environment for building applications
# devscripts: Utilities for Debian package development
# dh-make: Tool that converts source archives into Debian package source
# fakeroot: Allows users to simulate superuser privileges
# lintian: Debian package checker
# pbuilder: Personal package builder for Debian packages
# quilt: Tool to manage series of patches
# git: Version control system
# python3-venv and python3-pip: Tools for Python virtual environments and package installation
# bindfs: Used for mapping file permissions between host and container
# sudo: Allows privilege escalation
# mc (Midnight Commander): Text-based file manager
RUN apt-get install -y \
    build-essential \
    devscripts \
    dh-make \
    fakeroot \
    lintian \
    pbuilder \
    quilt \
    git \
    python3-venv \
    python3-pip \
    bindfs \
    sudo \
    mc && \
    gdebi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user 'app' with UID 1000 and add it to the 'sudoers' file
# This step enhances the security of the container by ensuring that not all operations are performed as root
RUN groupadd -g 1000 app && \
    useradd -m -u 1000 -g app -s /bin/bash app && \
    echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Update the bash configuration for the root and app users to include useful aliases
# These aliases are convenience shortcuts for common command-line operations
RUN echo 'alias ls="ls --color=auto -Fh"' >> /root/.bashrc && \
    echo 'alias dir="ls -l"' >> /root/.bashrc && \
    cp /root/.bashrc /home/app/.bashrc && chown app:app /home/app/.bashrc

# Switch to the app user before running any further commands
# This change improves container security by using a non-root user for subsequent operations
USER app

# Set the default command for the container
# This command keeps the container running and allows users to attach to it
CMD ["/bin/bash"]