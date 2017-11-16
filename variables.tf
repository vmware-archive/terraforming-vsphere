variable "vcenter_user" {}

variable "vcenter_password" {}

variable "vcenter_server" {}

variable "vcenter_dc" {}

variable "vcenter_cluster" {}

variable "vcenter_rp" {}

variable "vcenter_ds" {}

variable "om_ipv4_address" {}

variable "om_ipv4_prefix_length" {}

variable "om_ipv4_gateway" {}

variable "vcenter_network" {}

variable "vcenter_vms" {}

variable "om_template" {
  default = ""
}

variable "om_vmdk" {
  default = ""
}

variable "allow_unverified_ssl" {
  default = false
}
