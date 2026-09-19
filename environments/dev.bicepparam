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
      rgName: 'rg-sql-ag-dev1'

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
      vnetName: 'vnet-sql-ag-dev1'

      location: location

      resourceGroupName: 'rg-sql-ag-dev1'

      addressPrefixes: [
        '20.20.0.0/16'
      ]

      tags: {
        Environment: environment
        Project: 'SQL-AG'
        ManagedBy: 'Bicep'
        Owner: 'Infrastructure'
      }

      subnets: [

        {
          name: 'sql-subnet1'

          addressPrefix: '20.20.1.0/24'
        }

        {
          name: 'application-subnet1'

          addressPrefix: '20.20.2.0/24'
        }
        {
          name: 'appgw-subnet1'

          addressPrefix: '20.20.3.0/24'
        }
      ]
    }
  ]
}
