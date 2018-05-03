output "iaas" {
  value = "vsphere"
}

output "om" {
  value = "${vsphere_virtual_machine.vm.name}"
}
