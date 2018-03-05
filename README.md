# OSX-docker
OSX on Docker Env.

## Prepare Disk Image

1. refer to this [repository](https://github.com/hephaex/OSX-KVM), prepare Disk image of your macOS 
1. rename to osx.iso from generated ISO.
1. docker pull hephaex/osx

## Docker Run

```
docker run -d --name macOS \
--device /dev/kvm:/dev/kvm \
-p 5000:5000 \
-v ~/osx-docker/data:/data \
hephaex/osx
```

## Connect OSX
Connect to VNC using port no. 5000
