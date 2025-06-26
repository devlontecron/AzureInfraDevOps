param namePrefix string
param location string

var sqlServerName   = '${namePrefix}-sqlsvr'
var sqlDbName       = '${namePrefix}-sqldb'
param administratorLogin string = 'sqladmin'
@secure()
param administratorPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorPassword
    publicNetworkAccess: 'Enabled'
    version: '12.0'
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2022-11-01' = {
  name: '${sqlServer.name}/${sqlDbName}'
  location: location
  properties: {
    sku: {
      name: 'Basic'
      tier: 'Basic'
      capacity: 5
    }
  }
  dependsOn: [ sqlServer ]
}

output databaseId string = sqlDb.id
