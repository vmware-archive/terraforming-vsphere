variable "env_name" {
  type = "string"
}

variable "vcenter_user" {
  type = "string"
}

variable "vcenter_password" {
  type = "string"
}

variable "vcenter_server" {
  type = "string"
}

variable "vcenter_dc" {
  type = "string"
}

variable "vcenter_cluster" {
  type = "string"
}

variable "vcenter_network" {
  default = ""
  type    = "string"
}

variable "vcenter_rp" {
  default = ""
  type    = "string"
}

variable "vcenter_ds" {
  type = "string"
}

variable "om_ipv4_address" {
  default     = ""
  description = "opsman's IP from the outside. If using NSX-T, OM will see it's own IP as 10.0.1.10"
  type        = "string"
}

variable "om_DNS" {
  default = ""
  type    = "string"
}

variable "om_admin_password" {
  default = "admin"
  type    = "string"
}

variable "om_netmask0" {
  default = ""
  type    = "string"
}

variable "om_ntp_servers" {
  default = "time.nist.gov"
  type    = "string"
}

variable "om_custom_hostname" {
  default = ""
  type    = "string"
}

variable "om_gateway" {
  default = ""
  type    = "string"
}

variable "vcenter_vms" {
  default = ""
  type    = "string"
}

variable "om_template" {
  default = ""
  type    = "string"
}

variable "om_vmdk" {
  default = ""
  type    = "string"
}

variable "allow_unverified_ssl" {
  default = false
  type    = "string"
}

variable "nsxt" {
  default     = false
  description = "Set up NSX-T to Integrate with PAS."
  type        = "string"
}

variable "nsxt_host" {
  default     = ""
  description = "The nsx-t host."
  type        = "string"
}

variable "nsxt_username" {
  default     = "username"
  description = "The nsx-t username."
  type        = "string"
}

variable "nsxt_password" {
  default     = "password"
  description = "The nsx-t password."
  type        = "string"
}

variable "nsxt_subnet_cidr" {
  default     = ""
  description = "CIDR describing the range of IPs available to our network on the T0 router"
  type        = "string"
}

variable "nsxt_switching_profile" {
  default     = ""
  description = "The name of the spoof guard switching profile."
  type        = "string"
}

variable "nsxt_transport_zone" {
  default     = ""
  description = "The name of the overlay transport zone."
  type        = "string"
}

variable "nsxt_edge_cluster" {
  default     = ""
  description = "The name of the edge cluster."
  type        = "string"
}

variable "nsxt_t0_router" {
  default     = ""
  description = "The name of the logical tier 0 router."
  type        = "string"
}
