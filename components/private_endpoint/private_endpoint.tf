resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "${var.tenant}-vnet-link"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

# Setup private-link
resource "azurerm_private_endpoint" "endpoint" {
  name                = "storage-private-endpoint"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "storage-private-service-connection"
    private_connection_resource_id = var.storage_account_resource_id
    is_manual_connection           = true
    subresource_names              = ["blob"]
    request_message                = "Requesting access"
  }
}