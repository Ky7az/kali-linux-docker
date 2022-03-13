FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install kali-linux-core
RUN apt-get clean

# Packages
RUN apt-get -y install aircrack-ng amap beef burpsuite cewl chromium crackmapexec crowbar crunch curl dirb dirbuster dnsenum dnsrecon dnsutils \
    dos2unix enum4linux exploitdb ffuf ftp gcc gdb git gobuster hashcat hping3 hydra iputils-ping john joomscan kismet make medusa metasploit-framework \ 
    mimikatz nasm nbtscan ncat netcat-traditional nikto nmap ollydbg onesixtyone patator php powercat powershell powersploit proxychains4 \
    python2 python2-dev python3 python3-dev python3-impacket python3-pip python3-setuptools python-setuptools recon-ng responder samba samdump2 seclists \ 
    set shellter sipvicious smbclient smbmap snmp snmpenum socat sqlmap ssh sslscan tcpdump theharvester vim wafw00f weevely wfuzz whatweb whois wireshark wine \ 
    wordlists wpscan zaproxy zsh

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
RUN adduser huhu --disabled-password --gecos ''
RUN adduser huhu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN groupadd -r autologin
RUN gpasswd -a huhu autologin

# Zsh
ADD .zsh_history /home/huhu/.zsh_history

# Vim
COPY .vimrc /home/huhu

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]