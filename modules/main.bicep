targetScope = 'subscription'

@description('Deployment environment')
param environment string

@description('Default Azure location')
param location string

@description('Landing zone configuration')
param landingZones object


//===================================================
// RESOURCE GROUPS
//===================================================

module resourceGroupModule './resourcegroup.bicep' = [
  for rg in landingZones.resourceGroups: {

    name: 'rg-${rg.rgName}-${environment}'

    scope: subscription()

    params: {
      resourceGroupName: rg.rgName
      location: rg.location
      tags: rg.tags
    }
  }
]


//===================================================
// VIRTUAL NETWORKS
//===================================================

module vnetModule './networking/vnet.bicep' = [
  for vnet in landingZones.vnets: {

    name: 'vnet-${vnet.vnetName}-${environment}'

    scope: resourceGroup(vnet.resourceGroupName)

    dependsOn: [
      resourceGroupModule
    ]

    params: {
      vnetName: vnet.vnetName
      location: vnet.location
      addressPrefixes: vnet.addressPrefixes
      subnets: vnet.subnets
      tags: vnet.tags
    }
  }
]
