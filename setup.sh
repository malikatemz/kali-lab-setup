#!/bin/bash
# Kali Linux Lab Setup Script
# Sets up a fully configured pentest lab environment
set -e

echo "[*] Updating system..."
sudo apt-get update -qq && sudo apt-get upgrade -y -qq

echo "[*] Installing core tools..."
sudo apt-get install -y -qq \
  nmap masscan nikto gobuster dirb \
  wireshark tcpdump netcat-openbsd \
  sqlmap hydra john hashcat \
  metasploit-framework \
  burpsuite \
  git curl wget python3 python3-pip

echo "[*] Installing Python tools..."
pip3 install impacket scapy requests pwntools --quiet

echo "[*] Setting up wordlists..."
sudo mkdir -p /usr/share/wordlists
if [ ! -f /usr/share/wordlists/rockyou.txt ]; then
  sudo wget -q https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt \
    -O /usr/share/wordlists/rockyou.txt
  echo "  rockyou.txt downloaded"
fi

echo "[*] Configuring Metasploit database..."
sudo systemctl start postgresql
sudo msfdb init 2>/dev/null || true

echo "[*] Creating lab directory structure..."
mkdir -p ~/lab/{targets,exploits,reports,loot,tools}
mkdir -p ~/lab/targets/{web,network,active_directory}

echo ""
echo "[+] Lab setup complete!"
echo "    Directory: ~/lab/"
echo "    Run 'msfconsole' to start Metasploit"
echo "    Run 'burpsuite' to start Burp Suite"
