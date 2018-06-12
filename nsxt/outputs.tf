output "infrastructure_network" {
  value = "${element(concat(nsxt_logical_switch.infrastructure-ls.*.display_name, list("")), 0)}"
}

output "deployment_network" {
  value = "${element(concat(nsxt_logical_switch.deployment-ls.*.display_name, list("")), 0)}"
}

output "infrastructure_subnet" {
  value = "10.0.1.0/24"
}

output "infrastructure_gateway" {
  value = "10.0.1.1"
}

output "deployment_subnet" {
  value = "10.0.2.0/24"
}

output "deployment_gateway" {
  value = "10.0.2.1"
}

output "om_ipv4_address" {
  value = "${var.om_ipv4_address}"
}
