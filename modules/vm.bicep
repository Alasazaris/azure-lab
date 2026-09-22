param location string

@secure()
param adminPassword string

param adminUsername string

resource publicIp 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: 'pip-proiect01'
  location: location

  sku: {
    name: 'Standard'
  }

  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'vnet-proiect01'
}

resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: 'nic-proiect01'
  location: location

  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig01'
        properties: {
          privateIPAllocationMethod: 'Dynamic'

          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, 'subnet01')
          }

          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: 'vm-ubuntu-proiect01'
  location: location

  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2ls_v6'
    }

    osProfile: {
      computerName: 'vm-proiect01'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }

      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
