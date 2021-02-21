data "terraform_remote_state" "web" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "terraform242424"
    container_name       = "tfstate"
    key                  = "web_tfstate"
  }
}


  