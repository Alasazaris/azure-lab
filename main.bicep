targetScope = 'resourceGroup'

param location string = resourceGroup().location
@secure()
param adminPassword string

module vnetModule 'modules/vnet.bicep' = {
  name: 'vnetDeployment'

  params: {
    location: location
  }
}

module nsgModule 'modules/nsg.bicep' = {
  name: 'nsgDeployment'

  params: {
    location: location
  }
}

module vmModule 'modules/vm.bicep' = {
  name: 'vmDeployment'

  dependsOn: [
    vnetModule
  ]

  params: {
    location: location
    adminUsername: 'adminuser'
    adminPassword: adminPassword
  }
}
