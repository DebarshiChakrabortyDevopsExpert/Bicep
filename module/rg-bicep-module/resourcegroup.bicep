targetScope = 'subscription'
param commonTags object = {
  DeployedBy: 'AzureBicep'
  Owner     : 'IAC Team'
  DeployedAt: utcNow()
}

param rgdetail object

resource RGresource 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: (rgdetail.env == 'dev') ? 'rg-dev' : (rgdetail.env == 'uat') ? 'rg-uat' : 'rg-prod'
  location: rgdetail.location
  tags: union(commonTags,(rgdetail.tags) ? null : rgdetail.tags)
}
