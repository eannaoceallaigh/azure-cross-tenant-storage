resource "azurerm_virtual_network" "vnet" {
  name                = "${var.tenant}-vnet"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = [var.address_space]

  subnet {
    name           = "subnet1"
    address_prefix = var.subnet_address_prefix
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.tenant}-public-ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.tenant}-nsg"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_virtual_network.vnet.subnet.*.id[0]
  network_security_group_id = azurerm_network_security_group.nsg.id
}