# Azure Lab

My first hands-on project with **Bicep**, combined with Azure administration and Bash.

This is my way of learning **AZ-104 concepts through practice**, by building and managing Azure infrastructure instead of studying the services only from theory.

## What it contains

* Resource Group
* Virtual Network and subnet
* Network Security Group
* Ubuntu Virtual Machine
* Public IP and Network Interface
* Bicep modules
* Bash scripts for VM management
* SSH administration

## Structure

### `main.bicep`

* The Resource Group was created separately using Azure CLI, so the Bicep project is not tied to a specific Resource Group or region.
* The deployment uses the Resource Group scope and takes the location from the Resource Group.
* I removed the hardcoded administrator password and changed it to a secure parameter. The administrator username is passed to the VM module.
* The VM module depends on the VNet module, ensuring the network is created before the VM deployment.

### `modules/`

```text
modules/
├── vnet.bicep: Creates the Virtual Network and subnet and associates the subnet with the Network Security Group.
├── nsg.bicep: Creates the Network Security Group and defines the inbound SSH rule.
└── vm.bicep: Creates the Public IP, Network Interface and Ubuntu Virtual Machine and connects the VM to the subnet.
```

### `scripts/`

```text
scripts/
├── vm-manager.sh: Provides basic VM information, SSH connection, and start/stop operations.
└── vm-status.sh: Provides a simple way to check the current status of the Azure VM and its IP.
```
