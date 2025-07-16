#!/bin/bash

# ------------------------------------------------------------------------
# This script is placed in /etc/profile.d/
# Automatically sourced on login/ssh for all users
# ------------------------------------------------------------------------

# Clear the terminal
clear

function gradient_line {
    local text="$1"
    local start_color=(192 192 192) # Light gray
    local end_color=(0 0 255)       # Blue
    local steps=${#text}

    for ((i = 0; i < steps; i++)); do
        local r=$((start_color[0] + (end_color[0] - start_color[0]) * i / steps))
        local g=$((start_color[1] + (end_color[1] - start_color[1]) * i / steps))
        local b=$((start_color[2] + (end_color[2] - start_color[2]) * i / steps))
        printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:i:1}"
    done
    printf "\033[0m\n"
}

function gradient_line_green {
    local text="$1"
    local start_color=(0 255 0)
    local end_color=(0 128 0)
    local steps=${#text}

    for ((i = 0; i < steps; i++)); do
        local r=$((start_color[0] + (end_color[0] - start_color[0]) * i / steps))
        local g=$((start_color[1] + (end_color[1] - start_color[1]) * i / steps))
        local b=$((start_color[2] + (end_color[2] - start_color[2]) * i / steps))
        printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:i:1}"
    done
    printf "\033[0m\n"
}

# -------------------------
# Render Banner
# -------------------------
gradient_line "···················································"
gradient_line ":       _                    _ _                  :"
gradient_line ":  ___ (_)_ __ ___   ___  __| (_) __ _   ___ __ _ :"
gradient_line ": / _ \\| | '_ \` _ \\ / _ \\/ _\` | |/ _\` | / __/ _\` |:"
gradient_line ":|  __/| | | | | | |  __/ (_| | | (_| || (_| (_| |:"
gradient_line ": \\___|/ |_| |_| |_|\\___|\\__,_|_|\\__,_(_)___\\__,_|:"
gradient_line ":    |__/                                         :"
gradient_line "···················································"

# -------------------------
# Collect System Info
# -------------------------
loadavg=$(cut -d " " -f1-3 /proc/loadavg)
disk_usage=$(df -h / | awk 'NR==2 {print $5 " of " $2}')
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_percent=$((100 * mem_used / mem_total))
swap_total=$(free -m | awk '/Swap:/ {print $2}')
swap_used=$(free -m | awk '/Swap:/ {print $3}')
swap_percent=0
if [ "$swap_total" -gt 0 ]; then
    swap_percent=$((100 * swap_used / swap_total))
fi
process_count=$(ps -e --no-headers | wc -l)
user_count=$(who | wc -l)
ipv4_addr=$(hostname -I | awk '{print $1}')
ipv6_addr=$(ip -6 addr show scope global | grep inet6 | awk '{print $2}' | head -n1)

# -------------------------
# Print System Information
# -------------------------
gradient_line_green "=================== SYSTEM INFORMATION ===================="

echo -e "\033[36mSystem Date: \033[0m$(date)"
echo -e "\033[36mLoad Average: \033[0m$loadavg"
echo -e "\033[36mDisk Usage: \033[0m$disk_usage"
echo -e "\033[36mMemory Usage: \033[0m${mem_percent}% of ${mem_total}MB"
echo -e "\033[36mSwap Usage: \033[0m${swap_percent}% of ${swap_total}MB"
echo -e "\033[36mProcesses: \033[0m$process_count"
echo -e "\033[36mUsers Logged In: \033[0m$user_count"
echo -e "\033[36mIPv4 Address: \033[0m$ipv4_addr"
echo -e "\033[36mIPv6 Address: \033[0m${ipv6_addr:-N/A}"

gradient_line_green "==========================================================="
echo -e "\033[34mAbout This Box: \033[0mhttps://ejmedia.ca/client-lan-monitor"
gradient_line_green "==========================================================="
echo ""
