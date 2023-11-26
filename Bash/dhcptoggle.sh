##runnen op linux?
#!/bin/bash

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Define network interface and static IP configuration
interface="ens33"        # Change this to your network interface name
static_ip="192.168.32.50"  # Change this to your desired static IP address
netmask="255.255.255.0"   # Change this to your subnet mask
gateway="192.168.32.1"     # Change this to your gateway/router IP

# Modify the /etc/network/interfaces file to set a static IP configuration
cat > /etc/network/interfaces <<EOL
auto $interface
iface $interface inet static
    address $static_ip
    netmask $netmask
    gateway $gateway
EOL

# Restart the networking service to apply the changes
systemctl restart networking

echo "Static IP configuration set. Your IP address is now $static_ip"

