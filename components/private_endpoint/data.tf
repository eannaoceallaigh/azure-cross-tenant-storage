data "azurerm_resource_group" "resource_group" {
  name = "${var.tenant}-resource-group"
}

data "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  virtual_network_name = "${var.tenant}-vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}

data "azurerm_virtual_network" "vnet" {
  resource_group_name = data.azurerm_resource_group.resource_group.name
  name                = "${var.tenant}-vnet"
}