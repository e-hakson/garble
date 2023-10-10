#!/bin/bash

# Function to generate a random AES key and IV
generate_aes_key() {
    openssl rand -base64 32
}

generate_aes_iv() {
    openssl rand -base64 16
}

# Function to symmetrically encrypt a file using AES
encrypt_symmetric() {
    local input_file="$1"
    local output_file="$2"
    local aes_key="$3"
    local aes_iv="$4"
    
    openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -K "$aes_key" -iv "$aes_iv"
}

# Function to symmetrically decrypt a file using AES
decrypt_symmetric() {
    local input_file="$1"
    local output_file="$2"
    local aes_key="$3"
    local aes_iv="$4"
    
    openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -K "$aes_key" -iv "$aes_iv"
}

# Function to asymmetrically encrypt a file using RSA
encrypt_asymmetric() {
    local input_file="$1"
    local output_file="$2"
    local public_key="$3"
    
    openssl rsautl -encrypt -inkey "$public_key" -pubin -in "$input_file" -out "$output_file"
}

# Function to asymmetrically decrypt a file using RSA
decrypt_asymmetric() {
    local input_file="$1"
    local output_file="$2"
    local private_key="$3"
    
    openssl rsautl -decrypt -inkey "$private_key" -in "$input_file" -out "$output_file"
}

# Main menu
while true; do
    clear
    echo "Encryption Tool"
    echo "1. Symmetric Encryption (AES)"
    echo "2. Symmetric Decryption (AES)"
    echo "3. Asymmetric Encryption (RSA)"
    echo "4. Asymmetric Decryption (RSA)"
    echo "5. Quit"
    read -p "Choose an option (1/2/3/4/5): " option

    case $option in
        1)
            read -p "Enter input file: " input_file
            read -p "Enter output file: " output_file
            aes_key=$(generate_aes_key)
            aes_iv=$(generate_aes_iv)
            encrypt_symmetric "$input_file" "$output_file" "$aes_key" "$aes_iv"
            echo "Symmetric encryption complete."
            echo "AES Key: $aes_key"
            echo "AES IV: $aes_iv"
            ;;
        2)
            read -p "Enter input file: " input_file
            read -p "Enter output file: " output_file
            read -p "Enter AES Key: " aes_key
            read -p "Enter AES IV: " aes_iv
            decrypt_symmetric "$input_file" "$output_file" "$aes_key" "$aes_iv"
            echo "Symmetric decryption complete."
            ;;
        3)
            read -p "Enter input file: " input_file
            read -p "Enter output file: " output_file
            read -p "Enter recipient's public key file: " public_key
            encrypt_asymmetric "$input_file" "$output_file" "$public_key"
            echo "Asymmetric encryption complete."
            ;;
        4)
            read -p "Enter input file: " input_file
            read -p "Enter output file: " output_file
            read -p "Enter your private key file: " private_key
            decrypt_asymmetric "$input_file" "$output_file" "$private_key"
            echo "Asymmetric decryption complete."
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a valid option (1/2/3/4/5)."
            ;;
    esac

    read -p "Press Enter to continue..."
done
