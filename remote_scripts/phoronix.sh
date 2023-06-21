#!/bin/bash
set -euf -o pipefail

sudo apt install php-cli php-xml php-gd curl -y

# Download and extract Phoronix Test Suite
wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.4_all.deb
sudo dpkg -i phoronix-test-suite_10.8.4_all.deb

# Automatically accept the Phoronix Test Suite user agreement
echo "Y" | sudo phoronix-test-suite enterprise-setup

# Set Phoronix Test Suite to run in batch (headless) mode
echo "MODE=BATCH" | sudo tee -a /etc/phoronix-test-suite.conf

# Set Phoronix Test Suite to auto-download and auto-install required test files
echo "AUTO_INSTALL_DEPENDENCIES=true" | sudo tee -a /etc/phoronix-test-suite.conf
echo "DOWNLOAD_CACHE=true" | sudo tee -a /etc/phoronix-test-suite.conf

# Run the benchmark
sudo phoronix-test-suite benchmark productivity > /root/bench-output/phoronix-productivity.txt

