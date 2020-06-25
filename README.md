# raspi-ubuntu-ansible
Raspberry Pi Ubuntu lab provisioning with Ansible

# Overview: 
Repo contains necessary files to provision multiple Ubuntu Raspberry Pi in home lab. Each Pi SD card is flashed with the latest Ubuntu Server image for Ras Pi, and a user-data file with customized hostname is copied to boot partition. Once booted, cloud-init with the custom user-data file will set the hostname, install Avahi & Ansible, create an 'ansible' user with associated ssh key, and call ansible-pull to run the playbooks from this repo (though not necessary for purposes of this repo, this facilitates further Ansible configuration).

Ansible will further configure host networking (based on assigned hostname and assigned role & variables), setting IP, netmask, gateway, DNS server(s), and DNS search suffix(es) by creating a host-specific [Netplan](https://ubuntu.com/server/docs/network-configuration) file from the included template.  Ansible will set the timezone (from variable) and, based on assigned role (here 'standalone' or 'kubernetes'), install Docker & CIFS-Utils (custom need here), and make the Raspberry Pi devices ready for further configuration or package installations as appropriate.

Cloud-init portion based somewhat on https://github.com/StefanScherer/rpi-ubuntu, I like [Raspberry Pi Imager](https://www.raspberrypi.org/documentation/installation/installing-images/) instead of flash for ability to run from Windows, but at the cost of not being able to flash user-data file in same operation.

This replaces my Terraform bootstrap (https://github.com/clayshek/terraform-raspberrypi-bootstrap) for ease of use and combining provisionsing with some initial configuration.

# Usage:
- Contents here reflect my lab infrastructure, but with a few modifications should be portable elsewhere. My lab has two primary roles: 'standalone' which primarily is an Ansible control node, and misc Docker containers, and 'kubernetes' which is a 4 node k3s cluster (further setup using [Rancher's Ansible Kubernetes k3s playbook](https://github.com/rancher/k3s-ansible). Roles and package installations can be further customized.
- Simply flash Raspberry Pi SD card with desired [Ubuntu Server version](https://ubuntu.com/download/raspberry-pi) - successfully tested on v20.04 LTS; v18.04 has issues.
- Copy user-data to boot partition of SD card (first customize hostname value, which should be reflected in Ansible inventory.yml file and have a .yml variables file in host_vars, do any user/ssh key modifications as necessary, and update Git repo location as appropriate)
- Boot Raspberry Pi, after a few minutes, Pi should be provisioned 
- Troubleshoot logs at /var/log/cloud-init-output.log & /var/log/ansible-provision.run
