provider "vsphere" {
  user           = "${var.vcenter_user}"
  password       = "${var.vcenter_password}"
  vsphere_server = "${var.vcenter_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
}

terraform {
  required_version = "< 0.12.0"
}
