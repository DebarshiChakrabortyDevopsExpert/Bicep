param StorageValues object
param commonTags object = {
  DeployedBy: 'AzureBicep'
  Owner     : 'IAC Team'
  DeployedAt: utcNow()
}

// set min and max size of storage account name and dynamically generate a storage account name
@minLength(3)
@maxLength(24)
param storageAccountName string = toLower('stgbic${uniqueString(resourceGroup().id)}')

resource storageAcct 'Microsoft.Storage/storageAccounts@2022-09-01' = {

  //name: 'strg${toLower(StorageValues.name)}'
  name:     storageAccountName
  location: StorageValues.location
  sku: {
    name: (StorageValues.environmentType == 'dev') ? 'Standard_LRS' : (StorageValues.environmentType == 'uat') ? 'Standard_GRS' : 'Standard_GRS'
  }
  kind:     'Storage'
  tags:     union(commonTags,empty(StorageValues.tags) ? null : StorageValues.tags)
}
