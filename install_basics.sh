#!/bin/bash
# ----------------------------------------------
# install_basics.sh
# EJMedia monitoring box base installer
# ----------------------------------------------
# Usage: sudo bash install_basics.sh

#
# This just starts our install process:
# at the time of this writing, it does not include all of our custom scripts, code and customizations!
# This is here as a framework to start form if you're building your own network monitoring box
#

set -e

echo ">>> Updating system packages..."
apt update && apt -y upgrade

echo ">>> Installing common tools..."
apt install -y \
    curl wget git \
    nmap net-tools iproute2 \
    arp-scan \
    htop iftop \
    unzip gnupg lsb-release ca-certificates \
    python3 python3-pip

echo ">>> Installing Zabbix agent..."
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu$(lsb_release -rs)_all.deb
dpkg -i zabbix-release_6.4-1+ubuntu$(lsb_release -rs)_all.deb
apt update
apt install -y zabbix-agent

echo ">>> Enabling and starting Zabbix agent..."
systemctl enable zabbix-agent
systemctl start zabbix-agent

echo ">>> (Optional) Install Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up

echo ">>> Cleaning up..."
apt autoremove -y
apt clean

echo ">>> DONE!"
echo "Reboot recommended before heavy use."
