
@allowed([
  'yes'
  'no'
])
param deploy string 
param namePrefix string

param env string = 'prod'

param location string = resourceGroup().location

var storageName = '${namePrefix}${uniqueString(resourceGroup().id)}st'

resource storage 'Microsoft.Storage/storageAccounts@2021-06-01' = if (deploy == 'yes') {
  name: storageName
  location: location
  sku: {
    name: env == 'prod' ? 'Premium_LRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
  }
}

output resourceId string = storage.id
