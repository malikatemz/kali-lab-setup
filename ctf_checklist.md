# CTF Attack Checklist

## Reconnaissance
- [ ] Ping sweep: `nmap -sn 192.168.1.0/24`
- [ ] Port scan: `nmap -sV -sC -A -T4 <target>`
- [ ] Full port scan: `nmap -p- --min-rate 5000 <target>`
- [ ] UDP scan: `nmap -sU --top-ports 100 <target>`

## Web Enumeration
- [ ] Directory brute force: `gobuster dir -u http://<target> -w /usr/share/wordlists/dirb/common.txt`
- [ ] Nikto scan: `nikto -h http://<target>`
- [ ] View source, check robots.txt, sitemap.xml
- [ ] Check for LFI, SQLi, XSS

## Exploitation
- [ ] Search exploits: `searchsploit <service> <version>`
- [ ] Check Metasploit: `search type:exploit name:<service>`
- [ ] Try default credentials

## Post-Exploitation
- [ ] `whoami`, `id`, `uname -a`
- [ ] Check sudo: `sudo -l`
- [ ] Find SUID binaries: `find / -perm -4000 2>/dev/null`
- [ ] Check crontabs: `cat /etc/crontab`
- [ ] Search for passwords: `grep -r "password" /etc 2>/dev/null`

## Flags
- [ ] User flag: `cat ~/user.txt`
- [ ] Root flag: `cat /root/root.txt`
