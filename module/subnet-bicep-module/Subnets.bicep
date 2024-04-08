param subnetValues object


resource Subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' =  {
  name: '${subnetValues.vnetname}/${subnetValues.subnetname}'
  properties: {
    addressPrefix: subnetValues.addressPrefix
    natGateway: subnetValues.Natgatewayname== null ? null: {
      id: resourceId('Microsoft.Network/natGateways/', subnetValues.Natgatewayname)
    } 
    
    networkSecurityGroup:subnetValues.networkSecurityGroup== null ? null: { 
      id: resourceId('Microsoft.Networking/networkSecurityGroups', subnetValues.networkSecurityGroup)
    }
    routeTable: subnetValues.routeTable== null ? null:{
      id: resourceId('Microsoft.Network/routeTables', subnetValues.routeTable)
    }
    delegations:subnetValues.delegationname==null && subnetValues.delegationservicename== null?null: [
      {
        name: subnetValues.delegationname
        properties: {
          serviceName: subnetValues.delegationservicename
        }
      }
    ]  
  
    serviceEndpoints:subnetValues.serviceendpointname==null?null: [
      {
        service: subnetValues.serviceendpointname
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
  }
 
}


