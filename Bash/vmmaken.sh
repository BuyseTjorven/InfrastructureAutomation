#!/bin/bash

# Check if the required number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# Read the desired number of VMs from the argument
aantal_vm=$1

# Azure resource group and location
resource_group="cloud.infra.tjorven.buyse"
locatie="westeurope"

# Azure VM settings
vm_size="Standard_B1s" # Kies de gewenste VM-grootte
admin_username="tjorven"

# Timestamp voor VM-naam
timestamp=$(date +%Y%m%d%H%M%S)

# Genereer een nieuw SSH-sleutelpaar
ssh_key_path=~/.ssh/azure_vm_key
ssh_key_pub_path="$ssh_key_path.pub" # Public key file path
ssh-keygen -t rsa -b 2048 -f "$ssh_key_path" -N ""

# Toon het nieuw gegenereerde SSH-publieke sleutel in de terminal
echo "SSH public key:"
cat "$ssh_key_pub_path"

# Maak een Azure resourcegroep
az group create --name $resource_group --location $locatie

# Loop om het gewenste aantal VM's te maken
for ((i = 1; i <= $aantal_vm; i++)); do
    # Definieer de VM-naam
    vm_naam="ubuntu-vm-$timestamp-$i"

    # Maak een Ubuntu 22.04 VM met het nieuw gegenereerde SSH-sleutelpaar
    az vm create \
        --resource-group $resource_group \
        --name $vm_naam \
        --image UbuntuLTS \
        --admin-username $admin_username \
        --ssh-key-values "$ssh_key_pub_path" \
        --size $vm_size

    # Voeg een tag toe aan de VM-resources
    az resource tag --tags "student=BuyseTjörven" --ids $(az vm show --resource-group $resource_group --name $vm_naam --query 'id' --output tsv)
done

# Toon hoe lang het duurde om de VM's te maken
echo "VM's zijn gemaakt in resourcegroep $resource_group."