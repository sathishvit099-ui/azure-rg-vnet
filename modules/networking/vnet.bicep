@description('Virtual network name')
param vnetName string

@description('Azure region')
param location string

@description('VNet address prefixes')
param addressPrefixes array

@description('Subnet configuration')
param subnets array

@description('Resource tags')
param tags object


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnetName

  location: location

  tags: tags

  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }

    subnets: [
      for subnet in subnets: {
        name: subnet.name

        properties: {
          addressPrefix: subnet.addressPrefix
        }
      }
    ]
  }
}


output vnetId string = virtualNetwork.id

output vnetName string = virtualNetwork.name
