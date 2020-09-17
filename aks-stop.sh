#!/bin/bash

CLUSTER_NAME=$1
RESOURCE_GROUP=$2

NODE_RESOURCE_GROUP=$(az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query "nodeResourceGroup" -o tsv)

az vmss list -g $NODE_RESOURCE_GROUP --query "[].name" -o tsv | while read -r scale_set
do 
    echo "Shutting down scaleset in the AKS resource group. Scale Set: $scale_set"
    az vmss deallocate -g $NODE_RESOURCE_GROUP -n $scale_set
done


