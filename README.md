# Terraforming vSphere

### Prerequisites

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
vcenter_user=""
vcenter_password=""
vcenter_server=""
vcenter_dc="some-datacenter"
vcenter_cluster="some-cluster"
vcenter_rp="some-resource-pool"
vcenter_ds="some-datastore"
vcenter_network_ipv4_address="10.0.0.0"
vcenter_network_ipv4_prefix_length="24"
vcenter_network="passionfruit"
vcenter_vms="passionfruit_vms"
vcenter_templates="passionfruit_templates"
```

### Var Details
- vsphere_user: **(required)** Username for vSphere API operations.
- vsphere_password: **(required)** Password vSphere API operations.
- vsphere_server: **(required)** vCenter server name for vSphere API operations.


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
