module "nsxt" {
  source = "./nsxt"

  count = "${var.nsxt ? 1 : 0}"

  env_name             = "${var.env_name}"
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  vcenter_dc           = "${var.vcenter_dc}"
  vcenter_server       = "${var.vcenter_server}"

  nsxt_host              = "${var.nsxt_host}"
  nsxt_username          = "${var.nsxt_username}"
  nsxt_password          = "${var.nsxt_password}"
  nsxt_switching_profile = "${var.nsxt_switching_profile}"
  nsxt_transport_zone    = "${var.nsxt_transport_zone}"
  nsxt_edge_cluster      = "${var.nsxt_edge_cluster}"
  nsxt_t0_router         = "${var.nsxt_t0_router}"

  om_ipv4_address = "${var.om_ipv4_address}"
}
