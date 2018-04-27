output "infrastructure-network" {
  value = "${element(concat(nsxt_logical_switch.infrastructure-ls.*.display_name, list("")), 0)}"
}
