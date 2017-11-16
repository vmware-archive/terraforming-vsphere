resource "vsphere_virtual_machine" "om" {
  name     = "${var.vcenter_network}-om"
  hostname = "${var.vcenter_network}"
  folder   = "${var.vcenter_vms}"
  vcpu     = 2
  memory   = 4096

  skip_customization = true
  wait_for_guest_net = false

  datacenter    = "${var.vcenter_dc}"
  cluster       = "${var.vcenter_cluster}"
  resource_pool = "${var.vcenter_rp}"

  network_interface {
    label              = "${var.vcenter_network}"
    ipv4_address       = "${var.om_ipv4_address}"
    ipv4_prefix_length = "${var.om_ipv4_prefix_length}"
    ipv4_gateway       = "${var.om_ipv4_gateway}"
  }

  disk {
    datastore = "${var.vcenter_ds}"
    template  = "${var.om_template}"
    vmdk      = "${var.om_vmdk}"
  }
}
