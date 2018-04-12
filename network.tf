data "nsxt_logical_tier0_router" "t0_router" {
  display_name = "${var.nsx_t0_router}"
}

data "nsxt_transport_zone" "overlay_tz" {
  display_name = "${var.nsx_transport_zone}"
}

data "nsxt_edge_cluster" "edge_cluster" {
  display_name = "${var.nsx_edge_cluster}"
}

resource "nsxt_logical_tier1_router" "t1_router" {
  display_name = "${var.env_name}Tier1"
  edge_cluster_id = "${data.nsxt_edge_cluster.edge_cluster.id}"

  failover_mode               = "PREEMPTIVE"
  enable_router_advertisement = true
  advertise_connected_routes  = true
  advertise_static_routes     = false
  advertise_nat_routes        = true

  tag {
    scope = "ncp/cluster"
    tag = "${var.env_name}"
  }
}

resource "nsxt_logical_router_link_port_on_tier0" "link_port_t0" {
  display_name = "${var.env_name}_T0_PORT1"
  logical_router_id = "${data.nsxt_logical_tier0_router.t0_router.id}"

  tag {
    scope = "ncp/cluster"
    tag = "${var.env_name}"
  }
}

resource "nsxt_logical_router_link_port_on_tier1" "link_port_t1" {
  display_name = "${var.env_name}_T1_PORT1"
  logical_router_id = "${nsxt_logical_tier1_router.t1_router.id}"
  linked_logical_router_port_id = "${nsxt_logical_router_link_port_on_tier0.link_port_t0.id}"

  tag {
    scope = "ncp/cluster"
    tag = "${var.env_name}"
  }
}

resource "nsxt_logical_switch" "mgmt-switch" {
  admin_state = "UP"
  display_name = "${var.env_name}-mgmt-ls"
  transport_zone_id = "${data.nsxt_transport_zone.overlay_tz.id}"

  tag {
    scope = "ncp/cluster"
    tag = "${var.env_name}"
  }
}

resource "nsxt_logical_switch" "pas-switch" {
  admin_state = "UP"
  display_name = "${var.env_name}-pas-ls"
  transport_zone_id = "${data.nsxt_transport_zone.overlay_tz.id}"

  tag {
    scope = "ncp/cluster"
    tag = "${var.env_name}"
  }
}
