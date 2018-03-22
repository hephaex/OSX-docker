FROM ubuntu:16.04

MAINTAINER Mario Cho <hephaex@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive
ENV QEMU_AUDIO_DRV=none

# install packages 
RUN apt-get -qq update && apt-get -qq install -y \
    sudo git vim \
    qemu qemu-kvm qemu-utils \
    libguestfs-tools linux-image-generic uml-utilities \
    virt-manager libvirt-bin bridge-utils \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* 
    
RUN git clone https://github.com/hephaex/OSX-KVM.git \
    && cd OSX-KVM && git checkout -b test ded4522d17692b7d8d596f8ae3bba8f1bfaae26a

WORKDIR /OSX-KVM
COPY start-osx.sh /OSX-KVM

# Create Bootable ISO
RUN chmod 775 start-osx.sh \
    && rm Clover.qcow2 \
    && cd HighSierra \
    && ./clover-image.sh --iso Clover-v2.4k-4380-X64.iso \
        --cfg clover/config.plist.stripped.qemu \
        --img '../Clover.qcow2'

EXPOSE 5900
VOLUME /data

CMD ["./start-osx.sh"]
