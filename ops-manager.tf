data "vsphere_datacenter" "dc" {
  name = "${var.vcenter_dc}"
}

data "vsphere_datastore" "ds" {
  name          = "${var.vcenter_ds}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vcenter_rp}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "mgmt-switch" {
  name          = "${nsxt_logical_switch.mgmt-switch.display_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  depends_on = ["nsxt_logical_switch.mgmt-switch"]
}

data "vsphere_virtual_machine" "om_template" {
  name          = "${var.om_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.env_name}-om"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.ds.id}"

  num_cpus         = 2
  memory           = 8192
  guest_id         = "${data.vsphere_virtual_machine.om_template.guest_id}"
  folder           = "${var.vcenter_vms}"

  wait_for_guest_net_timeout = -1

  network_interface {
    network_id   = "${data.vsphere_network.mgmt-switch.id}"
    adapter_type = "${data.vsphere_virtual_machine.om_template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size  = "${data.vsphere_virtual_machine.om_template.disks.0.size}"
    datastore_id = "${data.vsphere_datastore.ds.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.om_template.id}"
  }

  vapp {
    properties {
      ip0 = "${var.om_ipv4_address}"
      gateway = "${var.om_gateway}"
      netmask0 = "${var.om_netmask0}"
      gateway = "${var.om_gateway}"
      DNS = "${var.om_DNS}"
      ntp_servers = "${var.om_ntp_servers}"
      admin_password = "${var.om_admin_password}"
      custom_hostname = "${var.om_custom_hostname}"
    }
  }
}

