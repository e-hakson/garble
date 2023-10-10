#!/bin/bash

# Function to calculate MD5 hash of a text
calculate_md5() {
    local text="$1"
    echo -n "$text" | md5sum | awk '{print $1}'
}

# Main menu
while true; do
    clear
    echo "Text to MD5 Hash Tool"
    echo "1. Calculate MD5 Hash"
    echo "2. Quit"
    read -p "Choose an option (1/2): " option

    case $option in
        1)
            read -p "Enter text to calculate MD5 hash: " input_text
            md5_hash=$(calculate_md5 "$input_text")
            echo "MD5 Hash:"
            echo "$md5_hash"
            ;;
        2)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a valid option (1/2)."
            ;;
    esac

    read -p "Press Enter to continue..."
done
