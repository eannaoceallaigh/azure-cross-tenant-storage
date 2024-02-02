resource "azurerm_resource_group" "resource_group" {
  name     = "${var.tenant}-resource-group"
  location = var.location
}