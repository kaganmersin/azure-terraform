web_server_rg             = "web-rg"
resource_prefix           = "web-server"
web_server_name           = "web"
environment               = "production"
web_server_count          = 2
terraform_script_version = "1.0.0"
domain_name_label        = "learning-tf-v2"

location_settings        = {
  us2w = {
    location = "westus2"
    address_space = "1.0.0.0/22"
    subnets = {
      web-server         = "1.0.1.0/24"
      AzureBastionSubnet = "1.0.2.0/24"    
    }
  },
  us2e = {
    location = "eastus2"
    address_space = "2.0.0.0/22"
    subnets = {
      web-server         = "2.0.1.0/24"
      AzureBastionSubnet = "2.0.2.0/24"    
    }
  }    
}
