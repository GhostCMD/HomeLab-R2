#!/bin/bash 


sudo dnf check-update
sudo touch /etc/dracut.conf.d/vfio.conf && sudo echo -e "force_drivers+=\"vfio vfio-pci vfio_iommu_type1 vfio_virqfd\"" > /etc/dracut.conf.d/vfio.conf
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install tuned tuned-profiles-realtime hwloc-gui git ansible -y

sed -i 's/quiet/quiet intel_iommu=on rd.driver.pre=vfio-pci isolcpus=5,11/' /etc/default/grub
sudo dracut --add-drivers "vfio vfio-pci vfio_iommu_type1  vfio_virqfd" -f 
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg && sudo grub2-mkconfig -o /boot/grub2/grub.cfg
