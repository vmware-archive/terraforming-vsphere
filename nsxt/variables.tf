variable "vcenter_user" {
  type = "string"
}

variable "vcenter_password" {
  type = "string"
}

variable "count" {
  type = "string"
}

variable "env_name" {
  type = "string"
}

variable "allow_unverified_ssl" {
  default = false
  type    = "string"
}

variable "vcenter_dc" {
  default     = ""
  description = "The vcenter datacenter."
  type        = "string"
}

variable "vcenter_server" {
  default     = ""
  description = "The vcenter server."
  type        = "string"
}

variable "nsxt_host" {
  default     = ""
  description = "The nsx-t host."
  type        = "string"
}

variable "nsxt_username" {
  default     = ""
  description = "The nsx-t username."
  type        = "string"
}

variable "nsxt_password" {
  default     = ""
  description = "The nsx-t password."
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

variable "nsxt_subnet_cidr" {
  default     = ""
  description = "CIDR describing the range of IPs available to our network on the T0 router"
  type        = "string"
}

variable "om_ipv4_address" {
  default     = ""
  description = "opsman's IP from the outside. If using NSX-T, OM will see it's own IP as 10.0.1.10"
  type        = "string"
}
