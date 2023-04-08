# Kali Linux Docker Image

- Build an image and start the container
```
docker build -t kali-linux-docker .
docker run -d -v --privileged --sysctl net.ipv6.conf.all.disable_ipv6=0 -p 22222:22 --name kali kali-linux-docker:latest
```

- Install Xpra and start a desktop session with X11 forwarding
```
xpra start-desktop --start=xfce4-session ssh://huhu@127.0.0.1:22222
```