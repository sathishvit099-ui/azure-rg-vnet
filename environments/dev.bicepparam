using '../modules/main.bicep'


//===================================================
// ENVIRONMENT
//===================================================

param environment = 'dev'

param location = 'centralus'


//===================================================
// LANDING ZONES
//===================================================

param landingZones = {

  //=================================================
  // RESOURCE GROUPS
  //=================================================

  resourceGroups: [

    {
      rgName: 'rg-sql-ag-dev'

      location: location

      tags: {
        Environment: environment
        Project: 'SQL-AG'
        ManagedBy: 'Bicep'
        Owner: 'Infrastructure'
      }
    }
  ]


  //=================================================
  // VIRTUAL NETWORKS
  //=================================================

  vnets: [

    {
      vnetName: 'vnet-sql-ag-dev'

      location: location

      resourceGroupName: 'rg-sql-ag-dev'

      addressPrefixes: [
        '10.10.0.0/16'
      ]

      tags: {
        Environment: environment
        Project: 'SQL-AG'
        ManagedBy: 'Bicep'
        Owner: 'Infrastructure'
      }

      subnets: [

        {
          name: 'sql-subnet'

          addressPrefix: '10.10.1.0/24'
        }

        {
          name: 'application-subnet'

          addressPrefix: '10.10.2.0/24'
        }
      ]
    }
  ]
}
