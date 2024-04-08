targetScope= 'subscription'

param rgNames array
param StorageNames array
param today string = utcNow('MM-dd-yyyy')

module rgmod 'module/rg-bicep-module/resourcegroup.bicep' = [for rgName in rgNames:  {
  scope: subscription()
  name: '${rgName.name}-${today}'
  params: {
    rgdetail: rgName.rgdetail
  }
}]

@batchSize(1)
module storagemod 'module/storage-bicep-module/storageaccount.bicep' = [

  for StorageName in StorageNames: {
      // Represents the scope
    scope: resourceGroup(StorageName.rgName)
      // Represents the Deployment name for storage Account
    name: 'storagedeployment-${today}'
      // Represents the dependency
    dependsOn:rgmod
      // Represents the parameters object defined in the storage module which recives inputs fro storageName.StorageValues
    params:{
      StorageValues : StorageName.Storageparameters
    }

  }
]
