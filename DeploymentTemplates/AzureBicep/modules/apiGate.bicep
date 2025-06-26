
param name string
param location string

resource appGw 'Microsoft.Network/applicationGateways@2023-02-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_v2'
    tier: 'Standard_v2'
    capacity: 1
  }
  properties: {
    gatewayIPConfigurations: [
      {
        name: 'gwIpConfig'
        properties: {
          subnet: {
            id: '/subscriptions/<SUBID>/resourceGroups/<RG>/providers/Microsoft.Network/virtualNetworks/<VNET>/subnets/appgw'
          }
        }
      }
    ]
    // Listeners, backend pools, etc. to be added as needed.
  }
}

output resourceId string = appGw.id
