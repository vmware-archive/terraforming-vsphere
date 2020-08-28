# DEPRECATION

This repo is going to be archived.
The terraform templates that _should_ be used for deploying an Ops Manager, PAS and/or PKS, can be found at https://github.com/pivotal/paving
No PRs or Issues will be responded to here.

# Terraforming vSphere

Please note that the master branch is generally *unstable*.
If you are looking for something "tested", please consume one
of our [releases](https://github.com/pivotal-cf/terraforming-vsphere/releases).

## What Does This Do?

You will get a booted ops-manager VM plus some networking.

## Looking to setup a different IAAS?

- [aws](https://github.com/pivotal-cf/terraforming-aws)
- [azure](https://github.com/pivotal-cf/terraforming-azure)
- [gcp](https://github.com/pivotal-cf/terraforming-gcp)
- [openstack](https://github.com/pivotal-cf/terraforming-openstack)

### Prerequisites

Your system needs `terraform`:

```bash
brew update
brew install terraform
```

The vCenter Role must have the following privileges:

  1. Datastore
  1. Folder (all)
  1. Network
  1. Resource
  1. Virtual Machine
  1. vCenter Inventory Service
  1. License

Refer to [vSphere Terraform Provider documentation](https://www.terraform.io/docs/providers/vsphere/index.html).

## Are you using Platform Automation?
Skip the creation of the Ops Manager VM to use Platform Automation. Be sure to include `om_vm = false` in your [vars](/README.md#var-details). If you create your Ops Manager using terraform, you will not be able to manage it with [Platform Automation](https://docs.pivotal.io/platform-automation).

Deployment of the infrastructure is still required.

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
om_DNS                = "x.x.x.x"
om_ntp_servers        = "x.x.x.x"
om_admin_password     = "some-password"
om_custom_hostname    = "some-hostname"
vcenter_network       = "some-network"
vcenter_vms           = "some-parent-folder/some-vms-folder"
om_template           = "some-ops-manager-template"
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
- om_DNS: **(optional)** OpsMgr DNS Servers, comma separated. Leave unset if DHCP is desired.
- om_ntp_servers: **(required)** OpsMgr NTP Servers, comma separated.
- om_admin_password: **(required)** OpsMgr VM password. The username is 'ubuntu'.
- om_custom_hostname: **(optional)** OpsMgr Hostname. Default is 'pivotal-ops-manager'.
- vcenter_network: **(required)** Label for the network interface.
- vcenter_vms: **(required)** Folder for launching vms.

- vcenter_rp: **(optional)** Resource Pool for launching vms.

- om_template: **(optional)** Ops Manager vm template.
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

**Note:** This will only destroy resources deployed by Terraform. You will need to clean up anything deployed on top of that infrastructure yourself. On a vanilla vSphere deployment, running `om delete-installation` first will suffice. If you are using PAS with NSX-T, in order to clean up all NSX-T resources you will need to run `cf delete-org $orgname` for every org in your CF deployment.

```bash
terraform destroy
```
