#!/bin/bash

# One-click Minecraft installer for Chromebook Linux

echo "Starting Minecraft setup..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install wget tar unzip -y

# Install Java 21 if missing
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
REQUIRED_VERSION="21"
if [[ $JAVA_VERSION != $REQUIRED_VERSION* ]]; then
    echo "Installing Java 21..."
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz -O ~/jdk-21_linux-x64_bin.tar.gz
    sudo mkdir -p /usr/lib/jvm
    sudo tar -xvf ~/jdk-21_linux-x64_bin.tar.gz -C /usr/lib/jvm
    sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-21/bin/java 1
    sudo update-alternatives --config java
else
    echo "Java 21 already installed."
fi

# Download Minecraft launcher
wget https://llaun.ch/jar -O ~/LL.jar
chmod +x ~/LL.jar

# Launch Minecraft
echo "Launching Minecraft..."
java -jar ~/LL.jar
