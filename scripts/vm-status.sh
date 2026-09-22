#!/bin/bash

VM_NAME="vm-ubuntu-proiect01"
RESOURCE_GROUP="rg-proiect01"

echo "=== Azure VM Status ==="

az vm get-instance-view \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --query "instanceView.statuses[1].displayStatus" \
  --output tsv

echo
echo "=== Public IP ==="

az vm list-ip-addresses \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
  --output tsv