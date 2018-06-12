output "iaas" {
  value = "vsphere"
}

output "om" {
  value = "${vsphere_virtual_machine.vm.name}"
}

output "om_ipv4_address" {
  value = "${var.om_ipv4_address}"
}
