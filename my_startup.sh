#!/bin/bash


# ------------------------------------------------------------------------
# This script is placed in /etc/profile.d/
# Any executable .sh file in /etc/profile.d/ is automatically sourced
# by /etc/profile for all users on login or when a new shell session starts.
#
# That means this script will run on every local console login or SSH connection.
# ------------------------------------------------------------------------


# Clear the terminal
clear

function gradient_line {
    local text="$1"
    local start_color=(192 192 192) # Light gray
    local end_color=(0 0 255)       # Blue
    local steps=${#text}

    for ((i = 0; i < steps; i++)); do
        # Calculate interpolated color
        local r=$((start_color[0] + (end_color[0] - start_color[0]) * i / steps))
        local g=$((start_color[1] + (end_color[1] - start_color[1]) * i / steps))
        local b=$((start_color[2] + (end_color[2] - start_color[2]) * i / steps))

        # Print character with calculated color
        printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:i:1}"
    done

    # Reset color
    printf "\033[0m\n"
}

function gradient_line_green {
    local text="$1"
    local start_color=(0 255 0)
    local end_color=(0 128 0)
    local steps=${#text}

    for ((i = 0; i < steps; i++)); do
        # Calculate interpolated color
        local r=$((start_color[0] + (end_color[0] - start_color[0]) * i / steps))
        local g=$((start_color[1] + (end_color[1] - start_color[1]) * i / steps))
        local b=$((start_color[2] + (end_color[2] - start_color[2]) * i / steps))

        # Print character with calculated color
        printf "\033[38;2;%d;%d;%dm%s" "$r" "$g" "$b" "${text:i:1}"
    done

    # Reset color
    printf "\033[0m\n"
}


# Render gradient ASCII art
gradient_line "···················································"
gradient_line ":       _                    _ _                  :"
gradient_line ":  ___ (_)_ __ ___   ___  __| (_) __ _   ___ __ _ :"
gradient_line ": / _ \\| | '_ \` _ \\ / _ \\/ _\` | |/ _\` | / __/ _\` |:"
gradient_line ":|  __/| | | | | | |  __/ (_| | | (_| || (_| (_| |:"
gradient_line ": \\___|/ |_| |_| |_|\\___|\\__,_|_|\\__,_(_)___\\__,_|:"
gradient_line ":    |__/                                         :"
gradient_line "···················································"

# System Information Section
gradient_line_green "======================================================"
echo -e "\033[36mWelcome to \033[0m$(hostname)\033[0m"
echo -e "\033[34mCurrent User: \033[0m$(whoami)"
echo -e "\033[33mDate and Time: \033[0m$(date)"
echo -e "\033[35mKernel Version: \033[0m$(uname -r)"
gradient_line_green "======================================================"
echo -e "\033[34mAbout This box: \033[0mhttps://ejmedia.ca/client-lan-monitor"
gradient_line_green "======================================================"
echo ""
