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

echo ""
echo ">>> Performing pre-scan cleanup..."
rm -f ${OUTPUT_XML} ${OUTPUT_TXT}

echo ""
echo ">>> Starting nmap scan (timeout 2 min per host)..."
sudo nmap -sV -p1-1000 -v --host-timeout 2m 192.168.1.0/24 -oX ${OUTPUT_XML}

echo ""
echo ">>> Scan completed. Generating readable summary..."

# Build a helpful summary file
echo "EJMedia Network Scan Summary - ${DATE}" >> ${OUTPUT_TXT}
echo "==================================================" >> ${OUTPUT_TXT}
echo "" >> ${OUTPUT_TXT}

# Use xmlstarlet (small tool to parse XML cleanly)
which xmlstarlet > /dev/null 2>&1 || sudo apt install -y xmlstarlet

# Loop through hosts
xmlstarlet sel -t -m "//host" -v "address[@addrtype='ipv4']/@addr" -o " " \
    -v "hostnames/hostname/@name" -n ${OUTPUT_XML} | while read line; do
    IP=$(echo $line | awk '{print $1}')
    HOSTNAME=$(echo $line | awk '{print $2}')
    PORTS=$(xmlstarlet sel -t -m "//host[address/@addr='${IP}']/ports/port[state/@state='open']" -v "@portid" -o " (" -v "service/@name" -o "), " ${OUTPUT_XML} | sed 's/, $//')

    if [ ! -z "$PORTS" ]; then
        echo "HOST: $IP ${HOSTNAME}" >> ${OUTPUT_TXT}
        echo "  - Open ports: $PORTS" >> ${OUTPUT_TXT}
        echo "" >> ${OUTPUT_TXT}
    fi
done

echo ">>> Summary saved to ${OUTPUT_TXT}"
echo ""
echo "Done!"
