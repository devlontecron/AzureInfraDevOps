param name string
param location string

resource afd 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
  properties: {
    enabledState: 'Enabled'
  }
}

output resourceId string = afd.id
