targetScope = 'subscription'

@description('Resource group name')
param resourceGroupName string

@description('Azure region')
param location string

@description('Resource group tags')
param tags object


resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}


output resourceGroupId string = resourceGroup.id

output resourceGroupName string = resourceGroup.name
