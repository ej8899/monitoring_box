#!/bin/bash
# ---------------------------------------------------
# run_network_scan.sh
# EJMedia monitoring box nmap wrapper
# ---------------------------------------------------
# Usage: sudo bash run_network_scan.sh

DATE=$(date +%F)
OUTPUT_XML="nmap-scan-${DATE}.xml"
OUTPUT_TXT="nmap-summary-${DATE}.txt"

echo "=============================================="
echo "EJMedia.ca Network Scan - $(date)"
echo "Running on host: $(hostname) - IP: $(hostname -I | awk '{print $1}')"
echo "=============================================="

echo ""
echo ">>> Performing pre-scan cleanup..."
rm -f ${OUTPUT_XML} ${OUTPUT_TXT}

echo ""
echo ">>> Starting nmap scan..."
sudo nmap -sV -p1-1000 -v --host-timeout 2m 192.168.1.0/24 -oX ${OUTPUT_XML}

echo ""
echo ">>> Scan completed. Generating summary..."

# Simple grep summary of live hosts & open ports
sudo nmap -sP 192.168.1.0/24 | grep "Nmap scan report for" > ${OUTPUT_TXT}

echo ""
echo ">>> Summary of discovered hosts written to ${OUTPUT_TXT}"
echo ">>> Full XML report saved to ${OUTPUT_XML}"
echo ""
echo "Done!"
