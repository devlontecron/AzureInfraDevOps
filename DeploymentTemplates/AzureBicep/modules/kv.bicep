param name string
param location string

resource kv 'Microsoft.KeyVault/vaults@2023-02-01-preview' = {
  name: name
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: [] // add policies later
    enableRbacAuthorization: true
    publicNetworkAccess: 'Enabled'
  }
}

output resourceId string = kv.id
