resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_private_dns_a_record" "dns_a" {
  name                = var.storage_account_name
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = 10
  records             = [azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address]
}