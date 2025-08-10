#!/bin/bash
# This script installs Kubernetes on a Linux system.

export host_ip=$(curl -s ifconfig.co/ip)

# Update the package list
sudo apt-get update -y
sudo apt install curl -y
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik --tls-san=$host_ip" sh -

sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml