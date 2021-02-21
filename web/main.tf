provider "azurerm" {
  features {}
}

provider "random" {
}

module "locations" {
  source = "./location"

  for_each = var.location_settings

    web_server_location      = each.value.location
    web_server_rg            = "${var.web_server_rg}-${each.key}"
    resource_prefix          = "${var.resource_prefix}-${each.key}"
    web_server_address_space = each.value.address_space
    web_server_name          = var.web_server_name
    environment              = var.environment
    web_server_count         = var.web_server_count
    web_server_subnets       = each.value.subnets
    terraform_script_version = var.terraform_script_version
    admin_password           = data.azurerm_key_vault_secret.admin_password.value
    domain_name_label        = var.domain_name_label
}

resource "azurerm_resource_group" "global_rg" {
  name     = "traffic-manager-rg"
  location = "westus2"
}

resource "azurerm_traffic_manager_profile" "traffic_manager" {
  name                   = "${var.resource_prefix}-traffic-manager"
  resource_group_name    = azurerm_resource_group.global_rg.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = var.domain_name_label
    ttl           = 100
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_endpoint" "traffic_manager" {

  for_each = var.location_settings

    name                = "${var.resource_prefix}-${each.key}-endpoint"
    resource_group_name = azurerm_resource_group.global_rg.name
    profile_name        = azurerm_traffic_manager_profile.traffic_manager.name
    target_resource_id  = module.locations[each.key].web_server_lb_public_ip_id
    type                = "azureEndpoints"
    weight              = 100
}
