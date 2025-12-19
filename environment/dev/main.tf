module "rg" {
  source = "../../modules/resource_group"
  rgs    = var.rgs
}

module "vnet" {
  source = "../../modules/vnet"
  depends_on = [ module.rg ]
  vnets  = var.vnets
}

module "subnet" {
  source  = "../../modules/subnet"
  depends_on = [ module.vnet ]
  subnets = var.subnets
}


module "pip" {
  source     = "../../modules/pip"
  pips       = var.pips
  rg_details = module.rg.rg_details
}

module "sqlserver" {
  source     = "../../modules/sql_server"
  sqlservers = var.sqlservers
  kvname     = var.kvname
  kvrg       = var.kvrg
  sqlid      = var.sqlid
  sqlpw      = var.sqlpw
  rg_details = module.rg.rg_details
}

module "sqldb" {
  source    = "../../modules/sql_database"
  depends_on = [ module.sqlserver ]
  databases = var.databases
  sqlserver = var.sqlserver
  rgname    = var.rgname
}

module "vm" {
  source     = "../../modules/virtual_machine"
  depends_on = [ module.subnet ]
  vms        = var.vms
  rg_details = module.rg.rg_details
  kvname     = var.kvname
  kvrg       = var.kvrg
  vmid       = var.vmid
  vmpw       = var.vmpw

}
