# raspi-ubuntu-ansible
Raspberry Pi Ubuntu lab provisioning with Ansible

# Overview: 
Repo contains necessary files to provision multiple Ubuntu Raspberry Pi in home lab. Each Pi SD card is flashed with the latest Ubuntu Server image for Ras Pi, and a user-data file with customized config (Ctrl-Shft-X in Raspbery Pi Imager) is copied to boot partition. Once booted, cloud-init with the custom user-data file will set the hostname, create a personalized user with associated ssh key (and locked password), and call ansible-pull to run the playbooks from this repo.

Ansible will further configure host networking (based on assigned hostname and assigned role & variables), setting IP, netmask, gateway, DNS server(s), and DNS search suffix(es) by creating a host-specific [Netplan](https://ubuntu.com/server/docs/network-configuration) file from the included template.  Ansible will, based on assigned role, install additional packages.

# Usage:
- Flash Raspberry Pi SD card with desired [Ubuntu Server version](https://ubuntu.com/download/raspberry-pi) - successfully tested on v24.04.1 LTS.
- Copy user-data to boot partition of SD card (first customize hostname value, which should be reflected in Ansible inventory.yml file and have a .yml variables file in host_vars, do any user/ssh key modifications as necessary, and update Git repo location as appropriate)
- Boot Raspberry Pi, after a few minutes, Pi should be provisioned (depending on Pi model and RAM, cloud-init / Ansible run could take 25+ minutes)
- Watch 'cloud-init status'. Troubleshoot logs at /var/log/cloud-init-output.log & /var/log/cloud-init.log.
