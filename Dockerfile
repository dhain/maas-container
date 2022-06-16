FROM ubuntu:focal

COPY files/etc/apt/apt.conf.d/proxy /etc/apt/apt.conf.d/proxy

RUN mkdir -p /etc/systemd/system/multi-user.target.wants \
    && mkdir -p /etc/systemd/user/sockets.target.wants \
    && mkdir -p /usr/lib/systemd/system-preset \
    && mkdir -p /usr/lib/systemd/user-preset \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates sudo cron lsb-release less dbconfig-no-thanks net-tools \
    && apt-get clean

COPY files/debconf-selections /
COPY files/postgresql_12.99_all.deb /
COPY files/etc/apt /etc/apt
COPY files/usr /usr
COPY files/etc/systemd/system-preset /etc/systemd/system-preset

RUN ln -s /bin/true /usr/bin/systemd-detect-virt \
    && ln -s named.service /usr/lib/systemd/system/bind9.service \
    && debconf-set-selections /debconf-selections && rm /debconf-selections \
    && dpkg -i /postgresql_12.99_all.deb && rm /postgresql_12.99_all.deb \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y maas nmap \
    && apt-get clean \
    && setcap CAP_NET_BIND_SERVICE=+eip $(readlink -f /usr/bin/python3) \
    && systemctl mask \
    dmesg.service grub-common.service grub-initrd-fallback.service cron.service squid.service \
    isc-dhcp-server6.service isc-dhcp-server.service named.service nginx.service rsyslog.service

COPY files /

ENTRYPOINT ["/entrypoint"]
