# Language, keyboard layout, and time zone
#
lang en_GB.UTF-8
keyboard --vckeymap=gb --xlayouts='gb'
timezone Europe/London --isUtc

# Partitioning
#
clearpart --all --initlabel
reqpart
partition / --grow --fstype=ext4

user --groups=wheel --name=packer --password=TempPassword.ForPacker1
#sshpw --username=packer  TempPacker --plaintext

repo --name=EPEL --baseurl=https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/
repo --name=Puppet --baseurl=https://yum.puppetlabs.com/puppet/el/8/x86_64/

%packages --nocore
epel-release
puppet-release
dnf
yum
audit
augeas
basesystem
bash
cloud-utils-growpart
coreutils
cronie
curl
e2fsprogs
filesystem
glibc
grubby
hostname
initscripts
iproute
iputils
irqbalance
kbd
less
man-db
NetworkManager
openssh-clients
openssh-server
passwd
policycoreutils
procps-ng
puppet
rng-tools
rootfiles
rpm
rsyslog
selinux-policy-targeted
setup
shadow-utils
sudo
systemd
tar
tuned
util-linux
%end

reboot     