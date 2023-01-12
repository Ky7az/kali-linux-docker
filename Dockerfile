FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install kali-linux-core
RUN apt-get clean

# Locale
RUN apt-get -y install locales
ENV LANG en_US.UTF-8
RUN echo "$LANG UTF-8" > /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG

# Packages
RUN apt-get -y install aircrack-ng amap apktool awscli beef binwalk bloodhound burpsuite cewl checksec chromium crackmapexec crowbar crunch curl default-mysql-client dex2jar dirb \
    dirbuster dnsenum dnsrecon dnsutils dos2unix enum4linux exiftool exploitdb fierce ffuf flameshot foremost ftp gcc gdb ghidra git gobuster hashcat hashid hexedit hping3 \
    hydra ipmitool iputils-ping jadx john joomscan kismet make medusa metasploit-framework mimikatz mongodb-clients nasm nbtscan ncat netcat-traditional nfs-common nikto nmap \
    ollydbg onesixtyone patator php powercat powershell powersploit proxychains4 python2 python2-dev python3 python3-dev python3-impacket python3-pip python3-setuptools \
    radare2 recon-ng redis-tools remmina responder ropper samba samdump2 seclists set shellter sipvicious smali smbclient smbmap smtp-user-enum snmp snmpcheck snmpenum \
    snmp-mibs-downloader socat sqlitebrowser sqlmap ssh sshpass sslscan sslyze steghide strace swaks tcpdump telnet tor torbrowser-launcher theharvester traceroute vim wafw00f \
    weevely wfuzz whatweb whois wireshark wine wordlists wpscan yara zaproxy zsh

# Python Packages
RUN pip3 install oletools[full]

# Ruby Packages
RUN gem install evil-winrm

# Git Repositories
RUN mkdir -p /opt/git
RUN git clone https://github.com/internetwache/GitTools.git /opt/git/GitTools
RUN git clone https://github.com/diegocr/netcat.git /opt/git/netcat

# Binaries
RUN mkdir -p /opt/bin
RUN wget -O /opt/bin/chisel_linux_amd64.gz "$(curl -s https://api.github.com/repos/jpillora/chisel/releases/latest | grep -Eo 'https.*linux_amd64.gz')" && gzip -d /opt/bin/chisel_linux_amd64.gz
RUN wget -O /opt/bin/chisel_windows_amd64.gz "$(curl -s https://api.github.com/repos/jpillora/chisel/releases/latest | grep -Eo 'https.*windows_amd64.gz')" && gzip -d /opt/bin/chisel_windows_amd64.gz
RUN wget -O /opt/bin/kerbrute_linux_amd64 https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64 && chmod +x /opt/bin/kerbrute_linux_amd64
RUN wget -O /opt/bin/linpeas.sh https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
RUN wget -O /opt/bin/linpeas_linux_amd64 https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas_linux_amd64
RUN wget -O /opt/bin/winPEAS.bat https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat
RUN wget -O /opt/bin/winPEASx64.exe https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe
RUN wget -O /opt/bin/pspy64 https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64

# GUI
RUN apt-get -y install kali-desktop-xfce lightdm

# LightDM
RUN echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
RUN mkdir /etc/lightdm/lightdm.conf.d
RUN echo "\
[LightDM]\n\
[Seat:*]\n\
type=xremote\n\
xserver-hostname=host.docker.internal\n\
xserver-display-number=0\n\
autologin-user=huhu\n\
autologin-user-timeout=0\n\
" > /etc/lightdm/lightdm.conf.d/lightdm.conf
ENV DISPLAY=host.docker.internal:0.0

# User huhu
RUN adduser huhu --shell /bin/zsh --disabled-password --gecos ''
RUN adduser huhu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN groupadd -r autologin
RUN gpasswd -a huhu autologin
RUN touch /home/huhu/.hushlogin # Hide msg from Kali developers

# Zsh
ADD .zsh_history /home/huhu/.zsh_history

# Vim
COPY .vimrc /home/huhu

# SSH
# RUN mkdir -p /home/huhu/.ssh && chmod 700 /home/huhu/.ssh
# COPY id_ed25519.pub /home/huhu/.ssh
# RUN chmod 600 /home/huhu/.ssh/id_ed25519.pub
# RUN cat /home/huhu/.ssh/id_ed25519.pub > /home/huhu/.ssh/authorized_keys

# Permissions
RUN chown -R huhu:huhu /home/huhu
RUN chown -R huhu:huhu /opt

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]