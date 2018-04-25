# Terraforming vSphere

### Prerequisites

Your system needs `terraform`:

```bash
brew update
brew install terraform
```

The vCenter Role must have the following privileges:

  0. Datastore
  0. Folder (all)
  0. Network
  0. Resource
  0. Virtual Machine
  0. vCenter Inventory Service
  0. License

Refer to [vSphere Terraform Provider documentation](https://www.terraform.io/docs/providers/vsphere/index.html).

### Var File

Copy the stub content below into a file called `terraform.tfvars` and put it in the root of this project.
These vars will be used when you run `terraform  apply`.
You should fill in the stub values with the correct content.

```hcl
env_name              = "some-env"
vcenter_user          = "some-user"
vcenter_password      = "some-password"
vcenter_server        = "some-server"
vcenter_dc            = "some-datacenter"
vcenter_cluster       = "some-cluster"
vcenter_rp            = "some-cluster/some-resource-pool"
vcenter_ds            = "some-datastore"
om_ipv4_address       = "x.x.x.x"
om_netmask0           = "255.x.x.x"
om_gateway            = "x.x.x.x"
om_dns                = "x.x.x.x"
om_ntp_servers        = "x.x.x.x"
om_admin_password     = "some-password"
om_custom_hostname    = "some-hostname"
vcenter_network       = "some-network"
vcenter_vms           = "some-vms-folder"
om_template           = "some-templates-folder"
```

### Var Details
- env_name: **(required)** Environment name.
- vsphere_user: **(required)** Username for vSphere API operations.
- vsphere_password: **(required)** Password for vSphere API operations.
- vsphere_server: **(required)** vCenter server name for vSphere API operations.
- vcenter_dc: **(required)** Datacenter for launching vms.
- vcenter_cluster: **(required)** Cluster for launching vms.
- vcenter_ds: **(required)** Datastore for the virtual disks.
- om_ipv4_address: **(optional)** OpsMgr static IPv4 address. Leave unset if DHCP is desired.
- om_netmask0: **(optional)** OpsMgr netmask. Leave unset if DHCP is desired.
- om_gateway: **(optional)** OpsMgr gateway. Leave unset if DHCP is desired.
- om_dns: **(optional)** OpsMgr dns Servers, comma separated. Leave unset if DHCP is desired.
- om_ntp_servers: **(required)** OpsMgr NTP Servers, comma separated.
- om_admin_password: **(required)** OpsMgr VM password. The username is 'ubuntu'.
- om_custom_hostname: **(optional)** OpsMgr Hostname. Default is 'pivotal-ops-manager'.
- vcenter_network: **(required)** Label for the network interface.
- vcenter_vms: **(required)** Folder for launching vms.

- vcenter_rp: **(optional)** Resource Pool for launching vms.

- om_template: **(optional)** Full path to the Ops Manager vm template.
- om_vmdk: **(optional)** If not specifying `vcenter_template`, specify path to a vmdk in the `vcenter_ds`.

- allow_unverified_ssl: **(optional)** Defaults to false. Set to true if your vcenter uses self-signed certs.


## Running

Note: please make sure you have created the `terraform.tfvars` file above as mentioned.

### Standing up environment

```bash
terraform init
terraform plan -out=plan
terraform apply
```

### Tearing down environment

```bash
terraform destroy
```
