network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - {{static_ip_and_mask}}
      gateway4: {{default_gateway}}
      dhcp4: false
      nameservers:
          search: [{{dns_search_suffix}}]
          addresses: [{{dns_server}}]
