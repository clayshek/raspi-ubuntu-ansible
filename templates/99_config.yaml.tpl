network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - {{static_ip_and_mask}}
      routes:
        - to: default
          via: {{default_gateway}}
      dhcp4: false
      nameservers:
          search: [{{dns_search_suffix}}]
          addresses: [{{dns_server}}]
