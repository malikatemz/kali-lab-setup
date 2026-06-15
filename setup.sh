#!/bin/bash
# Kali Linux VM - Pentesting Tools Setup Script
# Run this INSIDE your Kali Linux VM to install all pentesting tools
# (Not for Linux Mint host)

echo "[*] Updating system..."
sudo apt-get update -qq && sudo apt-get full-upgrade -y -qq

echo "[*] Installing core pentesting tools..."
sudo apt-get install -y -qq \
  nmap masscan nikto gobuster exploitdb \
  metasploit-framework sqlmap hydra medusa \
  wireshark tcpdump netcat-openbsd \
  john hashcat \
  burpsuite owasp-zap ffuf \
  ghidra autopsy radare2 \
  aircrack-ng kismet wifite \
  bettercap mitmproxy \
  subfinder amass nuclei dirbuster dirb \
  beef-xss

echo "[*] Installing build tools..."
sudo apt-get install -y -qq \
  git curl wget python3 python3-pip

echo "[*] Installing Python pentest tools..."
pip3 install scapy pwntools impacket xsstrike dirsearch pwndbg ropgadget --quiet

echo "[*] Installing SIEM tools..."
sudo apt-get install -y -qq zeek suricata

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
mkdir -p ~/lab/targets/{web,network,active-directory}

echo ""
echo "[+] Lab setup complete!"
echo "    Directory: ~/lab/"
echo "    Run 'msfconsole' to start Metasploit"
echo "    Run 'burpsuite' to start Burp Suite"
echo "    Run 'wireshark' to start Wireshark"
