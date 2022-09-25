# Kali Linux Docker Image

- Start a X server on your host

- Build image and start container
```
docker build -t kali-linux-docker .
docker run -d -v --privileged --sysctl net.ipv6.conf.all.disable_ipv6=0 --name kali kali-linux-docker:latest
```

- Override DISPLAY environment variable (by default 0.0)
```
-e "DISPLAY=host.docker.internal:X.0"
```