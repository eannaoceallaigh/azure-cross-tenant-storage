# Azure Cross Tenant Storage

This repo contains terraform code to demonstrate how private endpoints can be used to allow resources in one tenant and subscription to access a storage account in another tenant and subscription without the need to peer virtual networks or add any external networking configuration e.g. VPN.

This will also work if the subscriptions are in the same tenant. They only have to be in the same region.

The `infra` component should be deployed in one tenant, followed by `storage` in another tenant. Finally the `private_endpoint` component should be deployed in the first tenant and the resource id and name of the storage account should be passed to terraform as variables:

```
terraform apply --var-file=../../environments/tenant-01/tenant.tfvars --var storage_account_resource_id=/subscriptions/<SUBSCRIPTION ID>/resourceGroups/tenant-02-resource-group/providers/Microsoft.Storage/storageAccounts/tenant022024sa --var storage_account_name=tenant022024sa
```

When deployed, you should have the following resources in your first tenant:

- resource group
- virtual machine
- virtual network and subnet
- network security group
- private endpoint
- private dns zone

In your second tenant, you should have:

- resource group
- storage account