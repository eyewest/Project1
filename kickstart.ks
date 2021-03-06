#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use text mode install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=static --device=ens33 --gateway=10.2.6.1 --ip=10.2.7.229 --nameserver=10.14.1.10,10.11.0.51 --netmask=255.255.254.0 --ipv6=auto --activate
network  --bootproto=dhcp --hostname=CIT470-team2client.hh.nku.edu
# Reboot after installation
reboot
# Root password *** CHECK THE ROOT PW***
rootpw --plaintext 2_Team
# System services
services --enabled="chronyd"
# Do not configure the X Window System
skipx
# System timezone
timezone America/New_York --isUtc

# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part /var --fstype="xfs" --ondisk=sda --size=2500MB
part swap --fstype="swap" --ondisk=sda --size=512MB
part / --fstype="xfs" --ondisk=sda --size=7.5GB

%post --interpreter=/usr/bin/bash � log=/root/ks-postinstall.log

%end

%packages
@^minimal
@core
chrony
kexec-tools
net-tools
vim
bzip2
wget

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges �notempty
%end
