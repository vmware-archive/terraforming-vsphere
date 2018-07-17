output "iaas" {
  value = "vsphere"
}

output "om" {
  value = "${vsphere_virtual_machine.vm.name}"
}

output "om_ipv4_address" {
  value = "${var.om_ipv4_address}"
}

output "ops_manager_dns" {
  value = "${var.om_custom_hostname}"
}

output "haproxy_static_ip" {
  value = "${var.haproxy_static_ip}"
}

output "tcp_router_static_ip" {
  value = "${var.tcp_router_static_ip}"
}

output "sys_domain" {
  value = "${var.sys_domain}"
}

output "apps_domain" {
  value = "${var.apps_domain}"
}

output "tcp_domain" {
  value = "${var.tcp_domain}"
}

output "vcenter_server" {
  value = "${var.vcenter_server}"
}

output "vcenter_dc" {
  value = "${var.vcenter_dc}"
}

output "vcenter_cluster" {
  value = "${var.vcenter_cluster}"
}

output "vcenter_network" {
  value = "${var.vcenter_network}"
}

output "vcenter_rp" {
  value = "${var.vcenter_rp}"
}

output "vcenter_ephemeral_datastore" {
  value = "${var.vcenter_ds}"
}

output "vcenter_persistent_datastore" {
  value = "${var.vcenter_ds}"
}

output "vcenter_disk_folder" {
  value = "${var.om_disks}"
}

output "vcenter_template_folder" {
  value = "${var.vcenter_templates}"
}

output "vcenter_vm_folder" {
  value = "${var.vcenter_vms}"
}

output "ntp_servers" {
  value = "${var.om_ntp_servers}"
}

output "dns_servers" {
  value = "${var.om_DNS}"
}

output "subnet_cidr" {
  value = "${var.subnet_cidr}"
}

output "subnet_gateway" {
  value = "${var.om_gateway}"
}

output "subnet_identifier" {
  value = "${var.vcenter_network}"
}

output "subnet_reserved_ips" {
  value = "${var.subnet_reserved_ips != "" ? var.subnet_reserved_ips : format("%s-%s", cidrhost(var.subnet_cidr, 0), cidrhost(var.subnet_cidr, 10)) }"
}
