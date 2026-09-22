param location string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet-proiect01'
  location: location

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: 'nsg-proiect01'
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: 'subnet01'

  properties: {
    addressPrefix: '10.10.1.0/24'

    networkSecurityGroup: {
      id: nsg.id
    }
  }
}
