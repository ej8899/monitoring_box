#!/bin/bash
# ---------------------------------------------------
# run_network_scan.sh
# EJMedia.ca monitoring box nmap wrapper with human summary
# ---------------------------------------------------
# Usage: sudo bash run_network_scan.sh

DATE=$(date +%F)
OUTPUT_XML="nmap-scan-${DATE}.xml"
OUTPUT_TXT="nmap-summary-${DATE}.txt"

echo "=============================================="
echo "EJMedia.ca Network Scan - $(date)"
echo "Running on host: $(hostname) - IP: $(hostname -I | awk '{print $1}')"
echo "=============================================="


# Check if nmap is installed
if ! command -v nmap &> /dev/null; then
    echo ""
    echo ">>> nmap not found. Attempting to install..."
    sudo apt update && sudo apt install -y nmap

    if ! command -v nmap &> /dev/null; then
        echo "!!! nmap installation failed. Aborting scan."
        exit 1
    fi
else
    echo ""
    echo ">>> nmap is installed. Proceeding with scan..."
fi

echo ""
echo ">>> Performing pre-scan cleanup..."
rm -f ${OUTPUT_XML} ${OUTPUT_TXT}

echo ""
echo ">>> Starting nmap scan (timeout 2 min per host)..."
sudo nmap -sV -p1-1000 -v --host-timeout 2m 192.168.1.0/24 -oX ${OUTPUT_XML}

echo ""
echo ">>> Scan complete. Detailed XML report saved to ${OUTPUT_XML}"
echo "    (Upload your XML report to EJMedia.ca for analysis)"
