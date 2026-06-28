#!/bin/bash

# Install jdtls for Java 17
JDTLS_DIR="$HOME/.local/share/nvim/mason/packages/jdtls"

echo "Installing jdtls for Java 17..."
mkdir -p "$JDTLS_DIR"
wget -O /tmp/jdtls-java17.tar.gz 'https://download.eclipse.org/jdtls/milestones/1.9.0/jdt-language-server-1.9.0-202203031534.tar.gz'
tar -xzf /tmp/jdtls-java17.tar.gz -C "$JDTLS_DIR"
rm /tmp/jdtls-java17.tar.gz

echo "jdtls for Java 17 installed successfully!"
