provider "nsxt" {
  username = "${var.nsxt_username}"
  password = "${var.nsxt_password}"
  host     = "${var.nsxt_host != "" ? var.nsxt_host : var.vcenter_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
}
