# Terraform Cloud Azure Simple Example

A simple example of a Terraform root module to test VCS integration with Terraform Cloud. This was initially based on
the Terraform Getting Started Example Code, however that was using AWS. This repo modifies that simple example to
use Azure in a similarly simple manner.

## What will this do?

This is a Terraform configuration that will create a VM in your Azure subscription.

When you set up a Workspace on Terraform Cloud, you can link to this repository. Terraform Cloud can then run
`terraform plan` and `terraform apply` automatically when changes are pushed. For more information on how Terraform
Cloud interacts with Version Control Systems, see
[our VCS documentation](https://www.terraform.io/docs/cloud/run/ui.html).

## What are the prerequisites?

You must have an Azure subscription and provide your Azure credentials to Terraform Cloud.
Terraform Cloud encrypts and stores variables using
[Vault](https://www.vaultproject.io/).
For more information on how to store variables in Terraform Cloud, see
[our variable documentation](https://www.terraform.io/docs/cloud/workspaces/variables.html).

The values for `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET` should be saved as environment variables on your workspace.


## How to create client id for use in Terraform Cloud

1. Create Client ID

    ```bash
    az login

    az account list

    az account set --subscription="${SUBSCRIPTION_ID}"

    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
    ```

2. Test Client ID

    ```bash
    az login --service-principal -u ${CLIENT_ID} -p ${CLIENT_SECRET} --tenant ${TENANT_ID}

    az vm list-sizes --location westus
    ```

## Links

I used the following example as the starting point for this example

* [Quickstart: Configure a Linux virtual machine in Azure using Terraform](https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure)