#!/bin/bash

VM_NAME="vm-ubuntu-proiect01"
RESOURCE_GROUP="rg-proiect01"

case "$1" in

    status)
        az vm get-instance-view \
            --resource-group "$RESOURCE_GROUP" \
            --name "$VM_NAME" \
            --query "instanceView.statuses[1].displayStatus" \
            --output tsv
        ;;

    start)
        az vm start \
            --resource-group "$RESOURCE_GROUP" \
            --name "$VM_NAME"
        ;;

    stop)
        az vm stop \
            --resource-group "$RESOURCE_GROUP" \
            --name "$VM_NAME"
        ;;

    ssh)
        PUBLIC_IP=$(az vm list-ip-addresses \
            --resource-group "$RESOURCE_GROUP" \
            --name "$VM_NAME" \
            --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
            --output tsv)

        ssh "carol@$PUBLIC_IP"
        ;;

    info)
        PUBLIC_IP=$(az vm list-ip-addresses \
            --resource-group "$RESOURCE_GROUP" \
            --name "$VM_NAME" \
            --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
            --output tsv)

        ssh "carol@$PUBLIC_IP" '
            echo "=== HOSTNAME ==="
            hostname

            echo
            echo "=== USER ==="
            whoami

            echo
            echo "=== UPTIME ==="
            uptime

            echo
            echo "=== DISK ==="
            df -h /

            echo
            echo "=== MEMORY ==="
            free -h
        '
        ;;

    *)
        echo "Usage: $0 {status|start|stop|ssh|info}"
        exit 1
        ;;

esac
