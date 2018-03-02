variable "env_name" {}

variable "vcenter_user" {}

variable "vcenter_password" {}

variable "vcenter_server" {}

variable "vcenter_dc" {}

variable "vcenter_cluster" {}

variable "vcenter_rp" {
  default = ""
}

variable "vcenter_ds" {}

variable "om_ipv4_address" {
  default = ""
}

variable "om_DNS" {
  default = ""
}

variable "om_admin_password" {}

variable "om_netmask0" {
  default = ""
}

variable "om_ntp_servers" {}

variable "om_custom_hostname" {
  default = ""
}

variable "om_gateway" {
  default = ""
}

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
