#!/bin/bash

# Azure Subscription ID

# Resource Group
resource_group="labo2_storage"

# Location (e.g., eastus, westus, etc.)
location="westeurope"

# Virtual Machine Name
vm_name="your_vm_name"

# VM Username
vm_username="tjorven"

# VM Password (replace with your desired password)
vm_password="Tjorvenbuyse%"

# VM Size (e.g., Standard_DS1_v2, Standard_D2s_v3, etc.)
vm_size="Standard_DS1_v2"

# Ubuntu OS Image
os_image="Canonical:UbuntuServer:18.04-LTS:latest"

# Network Security Group Name
nsg_name="your_nsg_name"

# Public IP Address Name
public_ip_name="your_public_ip_name"

# Virtual Network Name
vnet_name="your_vnet_name"

# Subnet Name
subnet_name="your_subnet_name"

# Create a resource group
#az group create --name $resource_group --location $location

# Create a virtual network
az network vnet create --resource-group $resource_group --name $vnet_name --subnet-name $subnet_name

# Create a public IP address
az network public-ip create --resource-group $resource_group --name $public_ip_name --allocation-method Dynamic

# Create a network security group
#firewall rules nog toevoegen
az network nsg create --resource-group $resource_group --name $nsg_name

# Create a virtual network interface card
#hier of bij vm firewall rules nog toevoegen denk ik?
az network nic create \
  --resource-group $resource_group \
  --name "${vm_name}-nic" \
  --vnet-name $vnet_name \
  --subnet $subnet_name \
  --public-ip-address $public_ip_name \
  --network-security-group $nsg_name

# Create a virtual machine
#hier of bij virtual network rules nog toevoegen denk ik?
az vm create \
  --resource-group $resource_group \
  --name $vm_name \
  --location $location \
  --size $vm_size \
  --image $os_image \
  --admin-username $vm_username \
  --admin-password $vm_password \
  --nics "${vm_name}-nic"

# Output information about the VM
az vm show --resource-group $resource_group --name $vm_name --show-details --query "publicIps" --output tsv
