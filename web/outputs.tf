output "bastion_host_subnet_us2w" {
  value = module.locations["us2w"].bastion_host_subnet
}

output "all" {
  value = module.locations
}