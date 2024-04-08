
param vnetValues object
param DDosprotectionplandetails object
param ddosplan bool

resource ddosProtectionPlan 'Microsoft.Network/ddosProtectionPlans@2020-11-01' =  if (ddosplan == true) {
  name: DDosprotectionplandetails.ddosProtectionPlanName
  location:DDosprotectionplandetails.location
  dependsOn: []
}

resource Vnet 'Microsoft.Network/virtualNetworks@2021-03-01' =  {
  name: vnetValues.name
  location: vnetValues.location
  tags:empty(vnetValues.tags)? null:vnetValues.tags 
  properties: {
    addressSpace: {
      addressPrefixes: vnetValues.vnetAddressprefixes
    }
    enableDdosProtection: vnetValues.enableDdosProtection
    ddosProtectionPlan: DDosprotectionplandetails.ddosProtectionPlanName == vnetValues.ddosProtectionPlanName ? {
      id: resourceId('Microsoft.Network/ddosProtectionPlans', vnetValues.ddosProtectionPlanName)
    } : null
   
  }
}


