# Terraforming vSphere

### Prerequisites

Your system needs `terraform` v0.10.8 or above:

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
om_ipv4_address       = "10.0.0.0"
om_ipv4_prefix_length = "24"
om_ipv4_gateway       = "10.0.0.1"
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
- om_ipv4_address: **(required)** Static IPv4 to assign to vm.
- om_ipv4_prefix_length: **(required)** Prefix length to use when statically assigning the address.
- om_ipv4_gateway: **(required)** Gateway IP address to use when statically assigning the address.
- vcenter_network: **(required)** Label for the network interface.
- vcenter_vms: **(required)** Folder for launching vms.

- vcenter_rp: **(optional)** Resource Pool for launching vms. Requires full path.

- om_template: **(optional)** Folder for Ops Manager vm template.
- om_vmdk: **(optional)** If not specifying `vcenter_template`, specify path to a vmdk in the `vcenter_ds`.

- allow_unverified_ssl: **(optional)** Defaults to false. Set to true if your vcenter uses self-signed certs.


## Running

Note: please make sure you have created the `terraform.tfvars` file above as mentioned.

### Standing up environment

```bash
terraform init
terraform apply
```

### Tearing down environment

```bash
terraform destroy
```
