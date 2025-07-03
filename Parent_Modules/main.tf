module "callrg" {
  source        = "../Child_Modules/azurerm_resource_group"
  test1rgname   = "B17_G3_testrg"
  test1location = "West Europe"
}

module "callvnet" {
  depends_on        = [module.callrg]
  source            = "../Child_Modules/azurerm_virtual_network"
  test1vnetname     = "testvnet"
  test1location     = "West Europe"
  test1rgname       = "B17_G3_testrg"
  test1addressspace = ["10.0.0.0/16"]
}

module "callsubneta" {
  source               = "../Child_Modules/azurerm_subnet"
  depends_on           = [module.callvnet]
  test1subnetname      = "testfsubnet"
  test1rgname          = "B17_G3_testrg"
  test1addressprefixes = ["10.0.1.0/24"]
  test1vnetname        = "testvnet"
}

# module "callsubnetb" {
#   source               = "../Child_Modules/azurerm_subnet"
#   depends_on           = [module.callvnet]
#   test1subnetname      = "testbsubnet"
#   test1rgname          = "B17_G3_testrg"
#   test1addressprefixes = ["10.0.2.0/24"]
#   test1vnetname        = "testvnet"
# }

module "callpipa" {
  source                = "../Child_Modules/azurerm_public_ip"
  depends_on            = [module.callrg]
  test1pipname          = "testfpip"
  test1location         = "West Europe"
  test1rgname           = "B17_G3_testrg"
  test1allocationmethod = "Static"
  test1sku              = "Basic"
}

# module "callpipb" {
#   source                = "../Child_Modules/azurerm_public_ip"
#   depends_on            = [module.callrg]
#   test1pipname          = "testbpip"
#   test1location         = "West Europe"
#   test1rgname           = "B17_G3_testrg"
#   test1allocationmethod = "Static"
#   test1sku              = "Basic"
# }

module "callnica" {
  source          = "../Child_Modules/azurerm_network_interface"
  depends_on      = [module.callsubneta]
  test1subnetname = "testfsubnet"
  test1vnetname   = "testvnet"
  test1pipname    = "testfpip"
  test1rgname     = "B17_G3_testrg"
  test1nicname    = "testfnic"
  test1location   = "West Europe"
}

# module "callnicb" {
#   source          = "../Child_Modules/azurerm_network_interface"
#   depends_on      = [module.callsubnetb]
#   test1subnetname = "testbsubnet"
#   test1vnetname   = "testvnet"
#   test1pipname    = "testbpip"
#   test1rgname     = "B17_G3_testrg"
#   test1nicname    = "testbnic"
#   test1location   = "West Europe"
# }

module "callvma" {
  source            = "../Child_Modules/azurerm_virtual_machine"
  depends_on        = [module.callnica]
  datatest1nicname  = "testfnic"
  test1rgname       = "B17_G3_testrg"
  test1vmname       = "FrontendVM"
  test1location     = "West Europe"
  vmsize            = "Standard_B1s"
  image_publisher   = "Canonical"
  image_sku         = "20_04-lts"
  image_version     = "latest"
  image_offer       = "0001-com-ubuntu-server-focal"
  test1keyvaultname = "mykeyvaluttest"
  vmusername        = "vmusername"
  vmuserpassword    = "vmuserpw"
}

# module "callvmb" {
#   source           = "../Child_Modules/azurerm_virtual_machine"
#   depends_on       = [module.callnicb]
#   datatest1nicname = "testbnic"
#   test1rgname      = "B17_G3_testrg"
#   test1vmname      = "BackendVM"
#   test1location    = "West Europe"
#   vmsize           = "Standard_B1s"
#   image_publisher  = "Canonical"
#   image_sku        = "20_04-lts"
#   image_version    = "latest"
#   image_offer      = "0001-com-ubuntu-server-focal"
# }

module "callkv" {
  source                    = "../Child_Modules/azurerm_key-vault"
  depends_on                = [module.callrg]
  test1keyvaultname         = "mykeyvaluttest"
  test1keyvaultlocation     = "West Europe"
  test1rgname               = "B17_G3_testrg"
  test1keyvaultsecretunname = "vmusername"
  test1kvunvalue            = "aarushadmin"
  test1keyvaultsecretpwname = "vmuserpw"
  test1kvpwvalue            = "Odido@#9876ads"
}
