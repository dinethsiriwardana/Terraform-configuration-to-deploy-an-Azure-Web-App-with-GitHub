# Deploying a Docker Container on Azure using Terraform

This repository contains a Terraform configuration to deploy a Docker container on Azure. The configuration creates an Azure Resource Group, an Azure Container Group, and deploys a specified Docker image into the container group.

## Prerequisites

Ensure you have the following installed before proceeding:

- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure subscription

## Setup

1. Clone this repository to your local machine:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. Update the variables in the `terraform.tfvars` file or pass them during runtime:

   ```hcl
   subscription_id = "<your_azure_subscription_id>"
   ```

3. Replace the Docker image in the Terraform configuration with your image:
   ```hcl
   image  = "dinethsiriwardana/slcitiesfront:latest"
   ```

## Steps to Deploy

1. Authenticate with Azure:

   ```bash
   az login
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Validate the configuration (optional):

   ```bash
   terraform validate
   ```

4. Apply the Terraform configuration:

   ```bash
   terraform apply
   ```

   Provide the necessary input for the variable `subscription_id` if not set in `terraform.tfvars`.

5. Confirm the deployment when prompted.

## Outputs

After successful deployment, Terraform will output:

- `container_ip_address`: The public IP address of the container group.
- `container_fqdn`: The Fully Qualified Domain Name (FQDN) of the container group.

## Clean Up

To destroy the resources created by this Terraform configuration, run:

```bash
terraform destroy
```

## Configuration Details

### Terraform Version

This configuration uses the following Terraform provider:

- **AzureRM**:
  ```hcl
  azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.15.0"
  }
  ```

### Resources Created

1. **Azure Resource Group**:

   - Name: `docker-container-rg`
   - Location: `East US`

2. **Azure Container Group**:
   - Name: `docker-container-group`
   - DNS Name Label: `myapp-container-az-tf-mschamps`
   - OS Type: `Linux`
   - Public IP Address
   - Docker Image: `dinethsiriwardana/slcitiesfront:latest`

### Tags

- Environment: `dev`

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
