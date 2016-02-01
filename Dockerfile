FROM jdoss/fedora-systemd
MAINTAINER Joe Doss <joe@joedoss.com>
ENV container docker
ENV TERM linux

RUN dnf update -y; \
dnf install 'dnf-command(copr)' sudo dnsmasq iproute procps-ng -y; \
dnf copr enable jdoss/caddy -y; \
dnf install caddy -y; \
dnf clean all; \
adduser dockerhole -G wheel; \
echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
mkdir /home/dockerhole/logs; \
mkdir /home/dockerhole/caddy; \
mkdir /home/dockerhole/data; \
mkdir /home/dockerhole/bin; \
touch /home/dockerhole/data/dockerhole.txt \
/home/dockerhole/data/whitelist.txt \
/home/dockerhole/data/blacklist.txt \
/home/dockerhole/logs/download_lists.log \
/home/dockerhole/logs/dnsmasq.log

COPY caddy /home/dockerhole/caddy
COPY bin /home/dockerhole/bin
COPY system/caddy.service /etc/systemd/system
COPY system/dockerhole.service /etc/systemd/system
COPY system/dockerhole.timer /etc/systemd/system
COPY system/dockerhole_stats.service /etc/systemd/system
COPY system/dockerhole_stats.timer /etc/systemd/system
COPY system/dnsmasq.conf /etc/dnsmasq.conf

RUN chown dockerhole:dockerhole -R /home/dockerhole/; \
systemctl enable dockerhole.service; \
systemctl enable dockerhole.timer; \
systemctl enable dockerhole_stats.service; \
systemctl enable dockerhole_stats.timer; \
systemctl enable caddy.service; \
systemctl enable dnsmasq

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 80/tcp

CMD ["/usr/lib/systemd/systemd"]
