# 🔐 Linux Mint — Pentesting Lab Setup

Automated setup script and reference guides for a professional pentest lab on Linux Mint.

---

## 🖥️ VM Setup (Optional)

Create a virtual pentesting lab within Linux Mint using VirtualBox.

### Install VirtualBox
```bash
# Add Oracle repository
sudo sh -c "echo 'deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian '$(lsb_release -sc)' contrib' > /etc/apt/sources.list.d/virtualbox.list"

# Add signing key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

# Install VirtualBox
sudo apt update && sudo apt install -y virtualbox-7.0

# Install Extension Pack (for USB/USB3 support)
wget https://download.virtualbox.org/virtualbox/7.0.14/Oracle_VirtualBox_Extension_Pack-7.0.14.vbox-extpack
sudo VBoxManage extpack install Oracle_VirtualBox_Extension_Pack-7.0.14.vbox-extpack
```

### Recommended VM Configuration
- **RAM:** 8GB+ (16GB recommended)
- **CPU:** 4+ cores
- **Storage:** 100GB+ SSD
- **Network:** Bridged adapter (for target network access)

### Create Pentesting VM
```bash
# Create VM directory
mkdir -p ~/VirtualBox\ VMs/KaliPentestLab

# Create VM
VBoxManage createvm --name "KaliPentestLab" --ostype "Linux_64" --register

# Set memory and CPUs
VBoxManage modifyvm "KaliPentestLab" --memory 8192 --cpus 4

# Create virtual disk (100GB)
VBoxManage createhd --filename ~/VirtualBox\ VMs/KaliPentestLab/kali.vdi --size 102400

# Create SATA controller and attach disk
VBoxManage storagectl "KaliPentestLab" --name "SATA" --add sata
VBoxManage storageattach "KaliPentestLab" --storagectl "SATA" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/KaliPentestLab/kali.vdi

# Attach ISO (download Kali Linux first)
VBoxManage storagectl "KaliPentestLab" --name "IDE" --add ide
VBoxManage storageattach "KaliPentestLab" --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium /path/to/kali-linux.iso

# Set network to bridged (replace en0 with your network interface)
VBoxManage modifyvm "KaliPentestLab" --nic1 bridged --bridgeadapter1 en0

# Start VM
VBoxManage startvm "KaliPentestLab"
```

### Alternative: Install Kali Directly on Hardware
If you prefer native installation instead of VM:
```bash
# Download Kali Linux ISO
# https://www.kali.org/get-kali/#kali-installer

# Create bootable USB
sudo dd if=kali-linux.iso of=/dev/sdX bs=4M status=progress

# Boot from USB and install
```

---

## Quick Install (Linux Mint)

Run these commands in sequence for a complete installation:

### Step 1: Core Pentesting Tools
```bash
sudo apt update && sudo apt install -y \
  nmap masscan nikto gobuster \
  metasploit-framework sqlmap hydra medusa \
  wireshark tcpdump \
  john hashcat \
  python3 python3-pip
```

### Step 2: Web Application Testing
```bash
sudo apt install -y \
  burpsuite owasp-zap ffuf
```

### Step 3: Reverse Engineering & Forensics
```bash
sudo apt install -y \
  ghidra autopsy radare2
```

### Step 4: Wireless Security Testing
```bash
sudo apt install -y \
  aircrack-ng kismet wifite
```

### Step 5: Network Analysis & Proxy Tools
```bash
sudo apt install -y \
  bettercap mitmproxy
```

### Step 6: Recon & Vulnerability Tools
```bash
sudo apt install -y \
  subfinder amass nuclei dirsearch \
  xsstrike trivy scoutsuite \
  pwndbg ropgadget angr
```

### Step 7: Build Essentials
```bash
sudo apt install -y curl wget git build-essential
```

### Step 8: Python Tools
```bash
pip3 install scapy pwntools impacket
```

### Step 9: SIEM & Monitoring Tools
```bash
# Install Zeek
sudo apt install -y zeek

# Install Suricata
sudo apt install -y suricata

# Install Wazuh (SIEM)
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh
sudo bash wazuh-install.sh -a

# Install Security Onion (standalone)
# See: https://docs.securityonion.net/en/2.4/installation.html
```

### All-in-One (Single Command)
```bash
sudo apt update && sudo apt install -y nmap masscan nikto gobuster metasploit-framework sqlmap hydra medusa wireshark tcpdump john hashcat python3 python3-pip burpsuite owasp-zap ffuf ghidra autopsy radare2 aircrack-ng kismet wifite bettercap mitmproxy subfinder amass nuclei dirsearch xsstrike trivy scoutsuite pwndbg ropgadget angr curl wget git build-essential && pip3 install scapy pwntools impacket && sudo apt install -y zeek suricata
```

---

## 🧪 Tool Assessment Commands

Quick reference commands to verify each tool is installed and working.

### 1. Reconnaissance / OSINT
```bash
# Nmap - Network discovery
nmap -V
nmap -sn 192.168.1.0/24

# theHarvester - Email/domain harvesting
theHarvester -d example.com -b google

# Maltego - Run from menu
maltego

# Recon-ng
recon-ng
```

### 2. Web Application Testing
```bash
# Burp Suite
burpsuite &

# OWASP ZAP
zap.sh &

# sqlmap - SQL injection
sqlmap -u "http://target.com/page?id=1" --batch

# ffuf - Web fuzzer
ffuf -w wordlist.txt -u http://target.com/FUZZ
```

### 3. Exploitation Frameworks
```bash
# Metasploit Framework
msfconsole

# BeEF (Browser Exploitation Framework)
beef-xss
```

### 4. Wireless Security Testing
```bash
# Aircrack-ng
aircrack-ng --help

# Kismet
kismet

# Wifite
wifite --help
```

### 5. Password Auditing
```bash
# John the Ripper
john --test

# Hashcat
hashcat --help

# Hydra
hydra -h

# Medusa
medusa -h
```

### 6. Network Analysis
```bash
# Wireshark
wireshark &

# tcpdump
tcpdump --help
```

### 7. Digital Forensics / Reverse Engineering
```bash
# Autopsy
autopsy &

# Ghidra
ghidra &

# radare2
r2 --help
```

### 8. Additional Tools
```bash
# Bettercap
bettercap -help

# mitmproxy
mitmproxy &

# Subfinder
subfinder -version

# Amass
amass -version

# Masscan
masscan --help

# Nuclei
nuclei -version

# Nikto
nikto -Help

# dirsearch
python3 dirsearch.py -u http://target.com

# XSStrike
python3 xsstrike.py -u http://target.com

# Trivy
trivy --version

# Scout Suite
python3 scout.py --help

# pwndbg
pwndbg

# ROPgadget
ROPgadget --help

# angr
python3 -c "import angr; print(angr.__version__)"
```

### 9. SIEM / Monitoring Tools
```bash
# Wazuh
sudo systemctl status wazuh-manager

# Zeek
zeek --version

# Suricata
suricata --build-info

# Security Onion
sudo sosetup
```

---

## Setup
```bash
chmod +x setup.sh
./setup.sh
```

## What's Installed
- **Scanning:** nmap, masscan, nikto, gobuster
- **Exploitation:** Metasploit, SQLmap, Hydra, Medusa
- **Traffic analysis:** Wireshark, tcpdump
- **Password cracking:** John, Hashcat
- **Python:** impacket, scapy, pwntools

---

## Kali Linux — Common Pentesting Tool Categories

Built for security testing, assessment, training, and lab environments.

### 1. Reconnaissance / OSINT
- Nmap — network discovery and service detection
- theHarvester — emails, domains, public data
- Maltego — relationship mapping
- Recon-ng

### 2. Web Application Testing
- Burp Suite
- OWASP ZAP
- sqlmap
- ffuf

### 3. Exploitation Frameworks
- Metasploit Framework
- BeEF

### 4. Wireless Security Testing
- Aircrack-ng
- Kismet
- Wifite

### 5. Password Auditing
- John the Ripper
- Hashcat
- Hydra
- Medusa

### 6. Network Analysis
- Wireshark
- tcpdump

### 7. Digital Forensics / Reverse Engineering
- Autopsy
- Ghidra
- radare2

---

## BlackArch — Massive Offensive Security Repository (Arch-based)

BlackArch includes thousands of security packages and is more modular and research-heavy.

### 1. Recon
- Subfinder
- Amass
- Masscan

### 2. Vulnerability Discovery
- Nuclei
- Nikto

### 3. Web Security
- XSStrike
- dirsearch

### 4. Reverse Engineering / Binary Analysis
- pwndbg
- ROPgadget
- angr

### 5. Container / Cloud Security
- Trivy
- Scout Suite

### 6. Traffic & Protocol Analysis
- Bettercap
- mitmproxy

---

## Learning Stack

### Beginner → Intermediate
1. Nmap
2. Wireshark
3. Burp Suite
4. OWASP ZAP
5. Metasploit
6. John the Ripper
7. Ghidra

### Intermediate → Advanced
8. Amass
9. Nuclei
10. ffuf
11. Hashcat
12. angr
13. Bettercap

---

## Installed Tools Reference

| Tool | Category | Purpose |
|------|----------|---------|
| Kali Linux | OS | Pentesting distribution |
| Burp Suite | Web App Testing | Web vulnerability scanning |
| Nmap | Recon | Network discovery |
| Metasploit Framework | Exploitation | Penetration testing framework |
| Medusa | Password Auditing | Parallel brute-force login auditor |
| ffuf | Web Security | Fast web fuzzer |
| OWASP ZAP | Web App Testing | Web application security scanner |
| Wireshark | Network Analysis | Packet analyzer |
| Ghidra | Reverse Engineering | Software reverse engineering |
| Wazuh | SIEM | Security monitoring |
| Zeek | Network Analysis | Network security monitor |
| Suricata | IDS/IPS | Intrusion detection/prevention |
| Security Onion | SIEM | Security monitoring distribution |

## Lab Structure
```
~/lab/
  targets/web/
  targets/network/
  targets/active_directory/
  exploits/
  reports/
  loot/
```

## References
- [CTF Attack Checklist](ctf_checklist.md)

## Part of
[Cybersecurity + Automation + AI 5-Month Roadmap](https://github.com/malikatemz) — Month 1
