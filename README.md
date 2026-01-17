# Kali Linux Docker Image

- Build an image and start the container

```sh
docker build -t kali-linux-docker .
docker run -d --privileged --sysctl net.ipv6.conf.all.disable_ipv6=0 -p 22222:22 -p 33390:3390 -v /home/ky7az/Share:/home/huhu/Share --name kali kali-linux-docker:latest
```

- Install FreeRDP and start an X11 desktop session

```sh
xfreerdp /list:kbd | grep French # To get your keyboard layout
xfreerdp /f /v:127.0.0.1:33390 /u:huhu /p:huhu +dynamic-resolution +clipboard /kbd:layout:0x000040C
```
