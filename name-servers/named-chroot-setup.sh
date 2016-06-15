#!/bin/bash

# CentOS 7 with systemd

echo "Install bind"
yum install -y bind bind-utils bind-chroot

echo "Copy all bind related files to prepare bind chrooted environments"
cp -R /usr/share/doc/bind-*/sample/var/named/* /var/named/chroot/var/named/

echo "Create bind related files into chrooted directory"
rm -f /var/named/chroot/var/named/data/cache_dump.db
rm -f /var/named/chroot/var/named/data/named_stats.txt
rm -f /var/named/chroot/var/named/data/named_mem_stats.txt
rm -f /var/named/chroot/var/named/data/named.run
rm -f /var/named/chroot/var/named/dynamic/managed-keys.bind

touch /var/named/chroot/var/named/data/cache_dump.db
touch /var/named/chroot/var/named/data/named_stats.txt
touch /var/named/chroot/var/named/data/named_mem_stats.txt
touch /var/named/chroot/var/named/data/named.run
mkdir -p /var/named/chroot/var/named/dynamic
touch /var/named/chroot/var/named/dynamic/managed-keys.bind

echo "Copy config files"
cp -p named.conf /var/named/chroot/etc/named.conf

# Handle zone file(s)
chmod +x zone-copy.sh
source zone-copy.sh

echo "Change file owner in chroot"
chown -R root:named /var/named/chroot/

echo "Bind lock file should be writeable"
chmod -R 777 /var/named/chroot/var/named/data
chmod -R 777 /var/named/chroot/var/named/dynamic

echo "Stop and disable named service"
/usr/libexec/setup-named-chroot.sh /var/named/chroot on
systemctl stop named
systemctl disable named

echo "Start and enable bind-chroot service at boot"
systemctl start named-chroot
systemctl enable named-chroot
ln -fs '/usr/lib/systemd/system/named-chroot.service' '/etc/systemd/system/multi-user.target.wants/named-chroot.service'
