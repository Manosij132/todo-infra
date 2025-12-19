rgs = {
  rg1 = {
    name       = "rg-todomano"
    location   = "Japan East"
    managed_by = "terraform"
    tags = {
      owner = "Manosij"
      env   = "dev"
    }
  }
  rg2 = {
    name     = "rg-testmano"
    location = "Japan East"
  }
  rg3 = {
    name     = "rg-testmano2"
    location = "Japan East"
  }
}


vnets = {
  vnet1 = {
    name                = "todo-vnet"
    resource_group_name = "rg-todomano"
    location            = "Japan East"
    address_space       = ["10.10.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "frontend-sub"
    resource_group_name  = "rg-todomano"
    virtual_network_name = "todo-vnet"
    address_prefixes     = ["10.10.1.0/24"]
  }
  subnet2 = {
    name                 = "backend-sub"
    resource_group_name  = "rg-todomano"
    virtual_network_name = "todo-vnet"
    address_prefixes     = ["10.10.2.0/24"]
  }
}

pips = {
  pip1 = {
    name              = "frontendtodopipmano"
    rg_key            = "rg1"
    allocation_method = "Static"
  }
  pip2 = {
    name              = "backendtodopipmano"
    rg_key            = "rg1"
    allocation_method = "Static"
  }

}

sqlservers = {
  sqlserver1 = {
    name    = "sql-server-mano"
    rg_key  = "rg1"
    version = "12.0"


  }
}

kvname = "kvmano"
kvrg   = "rg-randommano"
sqlid  = "sqlid"
sqlpw  = "sqlpw"
vmid   = "vmid"
vmpw   = "vmpw"

databases = {

  database1 = {
    name = "sql-db-mano"

    // OPTIONAL VALUES — if user doesn't pass, NULL will be passed → Terraform will not send field
    sku_name     = "S0"
    max_size_gb  = 10
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"

    enclave_type = "VBS"

  }
}

sqlserver = "sql-server-mano"
rgname    = "rg-todomano"

vms = {
  vm1 = {
    name   = "frontend-vm"
    rg_key = "rg1"
    size   = "Standard_F2"
    subnet = "frontend-sub"
    vnet   = "todo-vnet"
    pip    = "frontendtodopipmano"
    nic = {
      name = "nic-appserver1"
      ip_config = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    }

    disable_password_authentication = false

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
      name                 = "frontend-osdisk"
    }

  }
}
