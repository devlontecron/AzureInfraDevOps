@allowed([ 'dev', 'int', 'prod' ])
param environment string = 'dev'

// Load the block that matches the selected env
var env = json(loadTextContent('./environmentVariables.json'))[environment]

// Map to your existing params
param namePrefix string = env.namePrefix
param location   string = env.location
param agentCount int = env.agentCount
param k8sVersion string = env.k8sVersion
@secure()
param administratorPassword string = env.administratorPassword


// -------------------- Front Door --------------------
module afd 'modules/azFD.bicep' = {
  name: '${namePrefix}-afd-m'
  params: {
    name: '${namePrefix}-afd'
    location: location
  }
}

// -------------------- API Management ----------------
module apim 'modules/apiManag.bicep' = {
  name: '${namePrefix}-apim-m'
  params: {
    name: '${namePrefix}-apim'
    location: location
    publisherName: 'Contoso'
    publisherEmail: 'admin@contoso.com'
  }
  dependsOn: [ afd ]
}

// -------------------- Application Gateway -----------
module appGw 'modules/apiGate.bicep' = {
  name: '${namePrefix}-appgw-m'
  params: {
    name: '${namePrefix}-agw'
    location: location
  }
  dependsOn: [ apim ]
}

// -------------------- AKS Cluster -------------------
module aks 'modules/aksCluster.bicep' = {
  name: '${namePrefix}-aks-m'
  params: {
    name: '${namePrefix}-aks'
    location: location
  }
  dependsOn: [ appGw ]
}

// -------------------- Key Vault ---------------------
module kv 'modules/kv.bicep' = {
  name: '${namePrefix}-kv-m'
  params: {
    name: '${namePrefix}-kv'
    location: location
  }
}

// -------------------- Azure SQL ---------------------
module sql 'modules/sql.bicep' = {
  name: '${namePrefix}-sql-m'
  params: {
    namePrefix: namePrefix
    location: location
    administratorLogin: 'sqladmin'
    administratorPassword: administratorPassword
  }
  dependsOn: [ aks ]
}

// -------------------- Storage (Blob) ----------------
module storage 'modules/blob.bicep' = {
  name: '${namePrefix}-st-m'
  params: {
    name: '${namePrefix}st'
    location: location
  }
  dependsOn: [ aks ]
}

// -------------------- Redis Cache -------------------
module redis 'modules/redis.bicep' = {
  name: '${namePrefix}-redis-m'
  params: {
    name: '${namePrefix}-redis'
    location: location
  }
  dependsOn: [ aks ]
}

// -------------------- Monitoring --------------------
module monitor 'modules/monitor.bicep' = {
  name: '${namePrefix}-mon-m'
  params: {
    namePrefix: namePrefix
    location: location
    targetResourceIds: [
      aks.outputs.resourceId
      sql.outputs.databaseId
      storage.outputs.storageId
      redis.outputs.redisId
    ]
  }
  dependsOn: [ sql, redis ]
}

// Outputs ----------------------------------------------------------
output aksClusterId string      = aks.outputs.resourceId
output sqlDatabaseId string     = sql.outputs.databaseId
output storageAccountId string  = storage.outputs.storageId
output redisCacheId string      = redis.outputs.redisId
output monitorWorkspaceId string = monitor.outputs.workspaceId
