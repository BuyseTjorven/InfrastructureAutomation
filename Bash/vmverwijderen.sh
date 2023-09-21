#!/bin/bash
#


#verwijderen not functiol




# Azure resource group where VMs are located
resource_group="cloud.infra.tjorven.buyse"

# List all VM names in the specified resource group
vm_names=$(az vm list --resource-group $resource_group --query "[].name" --output tsv)

# Check if there are VMs to delete
if [ -z "$vm_names" ]; then
    echo "No VMs found in resource group $resource_group."
    exit 1
fi

# Prompt for confirmation before deleting VMs and related resources
echo "The following VMs and their related resources will be deleted:"
echo "$vm_names"
read -p "Are you sure you want to delete these VMs and their related resources? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "VM and resource deletion canceled."
    exit 1
fi

# Loop through VM names and delete each one along with related resources
for vm_name in $vm_names; do
    az vm delete --resource-group $resource_group --name $vm_name --yes --no-wait
    echo "Deleting VM: $vm_name"

    # Delete associated resources (network interfaces, disks, etc.)
    az resource delete --ids $(az vm show --resource-group $resource_group --name $vm_name --query 'resources[].id' --output tsv) --yes
    echo "Deleting related resources for VM: $vm_name"
done

echo "VM and related resource deletion process started. Use 'az vm list -g $resource_group' to check the deletion status."
