output "iaas" {
  value = "vsphere"
}

output "om" {
  value = "${vsphere_virtual_machine.vm.name}"
}

output "om_ipv4_address" {
  value = "${var.om_ipv4_address}"
}

output "infrastructure_network_name" {
  value = "${var.nsxt ? module.nsxt.infrastructure_network : var.vcenter_network}"
}

output "infrastructure_network_cidr" {
  value = "${var.nsxt ? module.nsxt.infrastructure_subnet : ""}"
}

output "infrastructure_network_reserved_ip_range" {
  value = "${var.nsxt ? cidrhost(module.nsxt.infrastructure_subnet, 0) : ""}-${var.nsxt ? cidrhost(module.nsxt.infrastructure_subnet, 10) : ""}"
}

output "infrastructure_network_dns" {
  value = "${var.om_DNS}"
}

output "infrastructure_network_gateway" {
  value = "${var.nsxt ? module.nsxt.infrastructure_gateway : ""}"
}

output "deployment_network_name" {
  value = "${var.nsxt ? module.nsxt.deployment_network : ""}"
}

output "deployment_network_cidr" {
  value = "${var.nsxt ? module.nsxt.deployment_subnet : ""}"
}

output "deployment_network_reserved_ip_range" {
  value = "${var.nsxt ? cidrhost(module.nsxt.deployment_subnet, 0): ""}-${var.nsxt ? cidrhost(module.nsxt.deployment_subnet, 1) : ""}"
}

output "deployment_network_dns" {
  value = "${var.om_DNS}"
}

output "deployment_network_gateway" {
  value = "${var.nsxt ? module.nsxt.deployment_gateway : ""}"
}
