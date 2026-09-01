targetScope = 'subscription'

param environment string

param location string

param landingZones object


//===================================================
// RESOURCE GROUPS
//===================================================

module rModule 'resourcegroup.bicep' = [
  for rg in landingZones.resourceGroups: {

    name: 'rg-${rg.rgName}-${environment}-${location}'

    scope: subscription()

    params: {
      rgname: rg.rgName
      location: rg.location
      tags: rg.tags
    }
  }
]


//===================================================
// VNETS
//===================================================

module vnetModule 'networking/vnet.bicep' = [
  for vnet in landingZones.vnets: {

    name: 'vnet-${vnet.vnetName}-${environment}-${location}'

    scope: resourceGroup(vnet.resourceGroupName)

    // Resource Group must exist before VNet
    dependsOn: [
      rModule
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
