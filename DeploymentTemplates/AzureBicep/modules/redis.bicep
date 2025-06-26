param name string
param location string

resource redis 'Microsoft.Cache/Redis@2023-08-01' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
    family: 'C'
    capacity: 0
  }
  properties: {
    enableNonSslPort: false
  }
}

output redisId string = redis.id
