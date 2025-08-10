#!/bin/bash
# This script installs Docker on a Linux system.
# It is intended to be run as a root user or with sudo privileges.
sudo apt-get update -y
suso apt install wget curl git -y
# Download the Docker installation script
$ curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
# Add the current user to the Docker group to run Docker commands without sudo
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo systemctl restart docker
# Clean up the installation script
rm install-docker.sh