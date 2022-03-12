# Kali Linux Docker Image

- Start a X server on your host

- Build image and start container
```
docker build -t kali .
docker run -d -v --privileged --sysctl net.ipv6.conf.all.disable_ipv6=0 kali:latest
```