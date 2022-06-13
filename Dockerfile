FROM ubuntu:focal

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates sudo cron lsb-release \
    && apt-get clean \
    && mkdir -p /etc/systemd/system/multi-user.target.wants \
        /etc/systemd/user/sockets.target.wants

COPY files/usr/share/keyrings/maas-ppa.asc /usr/share/keyrings/maas-ppa.asc
COPY files/etc/apt/sources.list.d/maas-ppa.list /etc/apt/sources.list.d/maas-ppa.list
COPY files/usr/bin/systemctl /usr/bin/systemctl

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    maas nmap \
    && apt-get clean
#RUN systemctl disable avahi-daemon dmesg rsyslog isc-dhcp-server isc-dhcp-server6

COPY files /

ENTRYPOINT ["/usr/bin/systemctl"]
