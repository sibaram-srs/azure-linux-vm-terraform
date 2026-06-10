# Terraform Azure Linux VM

This project provisions an Azure Linux Virtual Machine using Terraform.

## Technologies Used

- Terraform
- Microsoft Azure
- Azure Resource Manager (ARM)

## Infrastructure Created

- Resource Group
- Virtual Network
- Subnet
- Network Interface
- Public IP
- Linux Virtual Machine

## Prerequisites

- Azure Subscription
- Terraform Installed
- Azure CLI Installed

## 🔐 Authentication

Login to Azure using CLI:

az login


📦 Getting Started
1. Clone the Repository
git clone https://github.com/sibaram-srs/azure-linux-vm-terraform.git

cd azure-linux-vm-terraform
2. Initialize Terraform
terraform init
3. Validate Configuration
terraform validate
4. Review Execution Plan
terraform plan
5. Deploy Infrastructure
terraform apply

Type yes when prompted.

🧹 Destroy Infrastructure (Optional)

To remove all created resources:

terraform destroy
