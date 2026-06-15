# azure-terraform-public-private-zone

## Pre-requisite
- Terraform v1.15.6 
- Azure CLI
- openssl (self-signed PFX certificate and connect group of VM)

## Architecture flow overview
![rchitecture](flow/azure-public-private-zone.jpg)

## How to work
## NOTE! Sometims Quotas of Azure Virtual Machine size might be facing limit. Check out the official website at [Azure](https://learn.microsoft.com/en-us/azure/aks/quotas-skus-regions).


Predefined terraform.tfvars variable
```
# Azure Subcription 
subscription_id = "0000-000-0000-0000-00000"
tenant_id       = "0000-000-0000-0000-00000"

# Username and publickey for Azure Bastion ssh. 
admin_username = "azureuser" 
admin_ssh_public_keys = [
  "ssh-rsa AAAAB3....",
]

# Password for Azure Application gateway self-signed certificate 
app_gateway_ssl_certificate_password = "Changeit!"
```

Predefined Azure environment variable
```
ARM_SUBSCRIPTION_ID="0000-000-0000-0000-00000"
ARM_TENANT_ID="0000-000-0000-0000-00000"
ARM_CLIENT_ID="0000-000-0000-0000-00000"
ARM_CLIENT_SECRET="0000-000-0000-0000-00000"
```

## Local Command
Predefined to add Azure CLI extension
```
$ az extension add --name bastion

$ az extension add -n ssh
```

Basic to run Terrafrom to provisioning Azure Resources.
```
# Prepare working directory
$ terraform init 

# Show the current state or a saved plan
$ terraform show

# Show changes required by the current configuration
$ terraform plan

# Create or update infrastructure
$ terraform apply

# Destroy previously-created infrastructure
$ terraform destroy
```

Example command to use Bastion connect to Virtua Machines.
```
# Set Azure CLI
$ az account set --subscription $subscription_id

# Verify bastion
$ az extension show --name bastion --output table

# Verify configured key matches
$ cat ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub
$ chmod 600 ~/.ssh/id_rsa

# connect to Group A
$ az network bastion ssh \
  --name bas-terraform-public-private-zone \
  --resource-group rg-terraform-public-private-zone \
  --target-resource-id "/subscriptions/4297c6b5-ecbd-4930-ad13-3f7e44822812/resourceGroups/rg-terraform-public-private-zone/providers/Microsoft.Compute/virtualMachines/terraform-public-private-zone-group-a-vm-1" \
  --auth-type ssh-key \
  --username azureuser \
  --ssh-key ~/.ssh/id_rsa

# Connect to Group B
$ az network bastion ssh \
  --name bas-terraform-public-private-zone \
  --resource-group rg-terraform-public-private-zone \
  --target-resource-id "/subscriptions/4297c6b5-ecbd-4930-ad13-3f7e44822812/resourceGroups/rg-terraform-public-private-zone/providers/Microsoft.Compute/virtualMachines/terraform-public-private-zone-group-b-vm-1" \
  --auth-type ssh-key \
  --username azureuser \
  --ssh-key ~/.ssh/id_rsa
```

## Result
### Terraform apply success.
![screenshot](img/output.png)

### Resources group
![screenshot](img/rg1.png)

### Virtual networks
![screenshot](img/VN1.png)

### Subnets
![screenshot](img/VN2.png)

### Network security groups
![screenshot](img/nsg1.png)
![screenshot](img/nsg2.png)

### Application gateway
![screenshot](img/appgateway.png)

### Virtua Machines
![screenshot](img/VM1.png)
![screenshot](img/VM2.png)
![screenshot](img/VM3.png)

### Bastion
![screenshot](img/bastion1.png)

### Use Bastion connect to Virtua Machines Group A
![screenshot](img/test-bastion-connect-vm-group-a.png)

### Use Bastion connect to Virtua Machines Group B
![screenshot](img/test-bastion-connect-vm-group-b.png)
