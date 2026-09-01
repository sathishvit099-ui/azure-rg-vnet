param vnetName string
param location string

param addressPrefixes array
param subnets array
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2025-05-01' = {
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

output vnetId string = vnet.id
