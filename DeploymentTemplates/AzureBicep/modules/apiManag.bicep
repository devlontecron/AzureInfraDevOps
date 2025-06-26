param name string
param location string
@allowed([ 'Consumption', 'Developer', 'Basic', 'Standard' ])
param skuName string = 'Consumption'
param publisherName string
param publisherEmail string

resource apim 'Microsoft.ApiManagement/service@2023-05-01-preview' = {
  name: name
  location: location
  sku: {
    name: skuName
    capacity: skuName == 'Consumption' ? 0 : 1
  }
  properties: {
    publisherName: publisherName
    publisherEmail: publisherEmail
  }
}

output resourceId string = apim.id
