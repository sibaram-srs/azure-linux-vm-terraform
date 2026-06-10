resource "azurerm_resource_group" "RG1" {
  name     = "sunny-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "VM-network"
  location            = "West Europe"
  resource_group_name = "sunny-rg"
  address_space       = ["10.0.0.0/16"]
  }

  resource "azurerm_subnet" "subent" {
  name                 = "example-subnet"
  resource_group_name  = "sunny-rg"
  virtual_network_name = "VM-network"
  address_prefixes     = ["10.0.1.0/24"]
  }


  resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = "West Europe"
  resource_group_name = "sunny-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subent.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.PIP.id
  }
}

resource "azurerm_public_ip" "PIP" {
  name                = "VMPIP"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name

  security_rule {
    name                       = "Allow-SSH"
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

resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  subnet_id                 = azurerm_subnet.subent.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_linux_virtual_machine" "VM" {
  name                = "sunny-machine"
  resource_group_name = azurerm_resource_group.RG1.name
  location            = azurerm_resource_group.RG1.location
  size                = "Standard_B2ls_v2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_password = "Password@123456"

  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}