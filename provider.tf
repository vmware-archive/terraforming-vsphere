provider "vsphere" {
  user           = "${var.vcenter_user}"
  password       = "${var.vcenter_password}"
  vsphere_server = "${var.vcenter_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
}

provider "nsxt" {
  host     = "${var.nsx_server}"
  username = "${var.nsx_user}"
  password = "${var.nsx_password}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
}
