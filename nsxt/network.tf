data "nsxt_transport_zone" "transport_zone" {
  display_name = "${var.nsxt_transport_zone}"

  count = "${var.count}"
}

data "nsxt_logical_tier0_router" "rtr0" {
  display_name = "${var.nsxt_t0_router}"

  count = "${var.count}"
}

data "nsxt_edge_cluster" "edge_cluster" {
  display_name = "${var.nsxt_edge_cluster}"

  count = "${var.count}"
}

data "vsphere_datacenter" "dc" {
  name = "${var.vcenter_dc}"

  count = "${var.count}"
}

data "vsphere_network" "network" {
  name          = "${nsxt_logical_switch.infrastructure-ls.display_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

  count = "${var.count}"
}

### The switching profile with type Spoof Guard.
data "nsxt_switching_profile" "switching_profile" {
  display_name = "${var.nsxt_switching_profile}"

  count = "${var.count}"
}

#### T0 destination network address translation rule to facilitate communication between Ops Manager and BOSH Director.
resource "nsxt_nat_rule" "dnat-om-bosh" {
  display_name = "${var.env_name}-dnat-om-bosh"
  action       = "DNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "DNAT Rule for facilitating communication between Ops Manager and BOSH Director. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_destination_network = "${var.om_ipv4_address}"
  translated_network        = "10.0.1.10"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_nat_rule" "dnat-pas" {
  display_name = "${var.env_name}-dnat-pas"
  action       = "DNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "DNAT Rule for facilitating communication to PAS. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_destination_network = "${cidrhost(var.nsxt_subnet_cidr, 1)}"
  translated_network        = "10.0.2.2"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

### T0 source network address translation rule to facilitate communication to Ops Manager.
resource "nsxt_nat_rule" "snat-om" {
  display_name = "${var.env_name}-snat-om"
  action       = "SNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "SNAT Rule for facilitating communication to Ops Manager. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = "10.0.1.10"
  translated_network   = "${var.om_ipv4_address}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

### T0 source network address translation rule to facilitate communication within Infrastructure network.
resource "nsxt_nat_rule" "snat-infrastructure" {
  display_name = "${var.env_name}-snat-infrastructure"
  action       = "SNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "SNAT Rule for facilitating communication within Infrastructure network. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = "10.0.1.0/24"
  translated_network   = "${cidrhost(var.nsxt_subnet_cidr, 2)}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

### T0 source network address translation rule to facilitate communication within Infrastructure network.
resource "nsxt_nat_rule" "snat-deployment" {
  display_name = "${var.env_name}-snat-deployment"
  action       = "SNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "SNAT Rule for facilitating communication within Infrastructure network. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = "10.0.2.0/24"
  translated_network   = "${cidrhost(var.nsxt_subnet_cidr, 2)}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_nat_rule" "snat-router" {
  display_name = "${var.env_name}-snat-router"
  action       = "SNAT"

  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
  description       = "SNAT Rule for facilitating communication to the Infrastructure network router. Provisioned by Terraform."
  enabled           = true
  logging           = false
  nat_pass          = true

  match_source_network = "10.0.2.2"
  translated_network   = "${cidrhost(var.nsxt_subnet_cidr, 1)}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

# TODO: need a service LS and a corresponding DNAT rule
# resource "nsxt_nat_rule" "snat-service" {
#   display_name = "${var.env_name}-snat-service"
#   action       = "SNAT"

#   logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"
#   description       = "SNAT Rule for facilitating communication to the Service network. Provisioned by Terraform."
#   enabled           = true
#   logging           = false
#   nat_pass          = true

#   match_source_network = "10.12.0.0/24"
#   translated_network   = "10.85.106.100"

#   tag {
#     scope = "ncp/cluster"
#     tag   = "${var.env_name}"
#   }

#   count = "${var.count}"
# }

### Infrastructure Resources

#### The logical switch for the infrastructure network (BOSH and Ops Manager).
resource "nsxt_logical_switch" "infrastructure-ls" {
  display_name = "${var.env_name}-infrastructure-ls"

  transport_zone_id = "${data.nsxt_transport_zone.transport_zone.id}"
  admin_state       = "UP"

  description      = "Infrastructure Logical Switch provisioned by Terraform"
  replication_mode = "MTEP"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

#### The logical port for the infrastructure network.
resource "nsxt_logical_port" "infrastructure-lp" {
  display_name = "${var.env_name}-infrastructure-lp"

  admin_state       = "UP"
  description       = "Infrastructure Logical Port provisioned by Terraform"
  logical_switch_id = "${nsxt_logical_switch.infrastructure-ls.id}"

  count = "${var.count}"
}

#### The downlink port connecting the infrastructure logical port to the tier1 router.
resource "nsxt_logical_router_downlink_port" "infrastructure-dp" {
  display_name = "${var.env_name}-infrastructure-dp"

  description                   = "Infrastructure downlink port provisioned by Terraform"
  logical_router_id             = "${nsxt_logical_tier1_router.infrastructure-t1.id}"
  linked_logical_switch_port_id = "${nsxt_logical_port.infrastructure-lp.id}"
  ip_address                    = "10.0.1.1/24"

  count = "${var.count}"
}

#### The logical port for the infrastructure network.
resource "nsxt_logical_port" "deployment-lp" {
  display_name = "${var.env_name}-deployment-lp"

  admin_state       = "UP"
  description       = "Infrastructure Logical Port provisioned by Terraform"
  logical_switch_id = "${nsxt_logical_switch.deployment-ls.id}"

  count = "${var.count}"
}

#### The downlink port connecting the deployment logical port to the tier1 router.
resource "nsxt_logical_router_downlink_port" "deployment-dp" {
  display_name = "${var.env_name}-deployment-dp"

  description                   = "Deployment downlink port provisioned by Terraform"
  logical_router_id             = "${nsxt_logical_tier1_router.deployment-t1.id}"
  linked_logical_switch_port_id = "${nsxt_logical_port.deployment-lp.id}"
  ip_address                    = "10.0.2.1/24"

  count = "${var.count}"
}

### The tier1 router for PAS to connect from the tier0 router for the Infrastructure network.
resource "nsxt_logical_tier1_router" "infrastructure-t1" {
  display_name = "${var.env_name}-infrastructure-t1"

  description     = "Infrastructure Tier 1 Router provisioned by Terraform"
  failover_mode   = "PREEMPTIVE"
  edge_cluster_id = "${data.nsxt_edge_cluster.edge_cluster.id}"

  enable_router_advertisement = true
  advertise_connected_routes  = true

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_logical_router_link_port_on_tier0" "t0-to-infrastructure-t1" {
  display_name = "${var.env_name}-t0-to-infrastructure-t1"

  description       = "Link Port on Logical Tier 0 Router connecting to Infrastructure Tier 1 Router. Provisioned by Terraform."
  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_logical_router_link_port_on_tier1" "infrastructure-t1-to-t0" {
  display_name = "${var.env_name}-infrastructure-t1-to-t0"

  description                   = "Link Port on Infrastructure Tier 1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = "${nsxt_logical_tier1_router.infrastructure-t1.id}"
  linked_logical_router_port_id = "${nsxt_logical_router_link_port_on_tier0.t0-to-infrastructure-t1.id}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

### Deployment Resources

#### The logical switch for the deployment network (PAS).
resource "nsxt_logical_switch" "deployment-ls" {
  display_name = "${var.env_name}-deployment-ls"

  transport_zone_id = "${data.nsxt_transport_zone.transport_zone.id}"
  admin_state       = "UP"

  description      = "Deployment Logical Switch provisioned by Terraform"
  replication_mode = "MTEP"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

### The tier1 router for PAS to connect from the tier0 router for the Deployment network.
resource "nsxt_logical_tier1_router" "deployment-t1" {
  display_name = "${var.env_name}-deployment-t1"

  description     = "Deployment Tier 1 Router. Provisioned by Terraform."
  failover_mode   = "PREEMPTIVE"
  edge_cluster_id = "${data.nsxt_edge_cluster.edge_cluster.id}"

  enable_router_advertisement = true
  advertise_connected_routes  = true

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_logical_router_link_port_on_tier0" "t0-to-deployment-t1" {
  display_name = "${var.env_name}-t0-to-deployment-t1"

  description       = "Link Port on Logical Tier 0 Router connecting to Deployment Tier 1 Router. Provisioned by Terraform."
  logical_router_id = "${data.nsxt_logical_tier0_router.rtr0.id}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}

resource "nsxt_logical_router_link_port_on_tier1" "deployment-t1-to-t0" {
  display_name = "${var.env_name}-deployment-t1-to-t0"

  description                   = "Link Port on Deployment Tier 1 Router connecting to Logical Tier 0 Router. Provisioned by Terraform."
  logical_router_id             = "${nsxt_logical_tier1_router.deployment-t1.id}"
  linked_logical_router_port_id = "${nsxt_logical_router_link_port_on_tier0.t0-to-deployment-t1.id}"

  tag {
    scope = "ncp/cluster"
    tag   = "${var.env_name}"
  }

  count = "${var.count}"
}
