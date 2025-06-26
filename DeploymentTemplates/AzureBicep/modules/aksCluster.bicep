
param name string
param location string

@minValue(1)
param agentCount int = 3
param k8sVersion string = '1.29'

resource aks 'Microsoft.ContainerService/managedClusters@2023-05-01' = {
  name: name
  location: location
  sku: {
    name: 'Base'
    tier: 'Standard'
  }
  properties: {
    kubernetesVersion: k8sVersion
    dnsPrefix: '${name}-dns'
    agentPoolProfiles: [
      {
        name: 'nodepool'
        count: agentCount
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
    identity: {
      type: 'SystemAssigned'
    }
  }
}

output resourceId string = aks.id
