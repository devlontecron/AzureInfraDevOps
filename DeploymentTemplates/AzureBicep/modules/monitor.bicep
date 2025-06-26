param namePrefix string
param location string
param targetResourceIds array

var workspaceName = '${namePrefix}-law'

resource la 'Microsoft.OperationalInsights/workspaces@2023-01-01-preview' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

// Loop diagnostic settings for each resource passed in
@batchSize(1)
module diag './diag.bicep' = [for id in targetResourceIds: {
  name: '${namePrefix}-diag-${uniqueString(id)}'
  params: {
    targetId: id
    logAnalyticsWorkspaceId: la.id
  }
}]

output workspaceId string = la.id
