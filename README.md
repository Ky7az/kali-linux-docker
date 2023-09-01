# Kali Linux Docker Image

- Build an image and start the container
```sh
docker build -t kali-linux-docker .
docker run -d -v --privileged --sysctl net.ipv6.conf.all.disable_ipv6=0 -p 22222:22 -p 33389:3389 --name kali kali-linux-docker:latest
```

- Install FreeRDP and start an X11 desktop session
```sh
# Windows
wfreerdp.exe /f /v:127.0.0.1:33389 /u:huhu /p:huhu /floatbar /smart-sizing +clipboard

# Linux
xfreerdp /f /v:127.0.0.1:33389 /u:huhu /p:huhu /floatbar /smart-sizing +clipboard
```