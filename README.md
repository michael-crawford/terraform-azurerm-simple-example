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

You must have an Azure subscription, create a Service Principal for use by Terravorm, and then provide the details of
this Azure credential to Terraform Cloud via a Variable Set. Terraform Cloud encrypts and stores variables using
[Vault](https://www.vaultproject.io/). For more information on how to store variables in Terraform Cloud, see
[our variable documentation](https://www.terraform.io/docs/cloud/workspaces/variables.html).

The values for `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET` should be saved as
environment variables on your workspace.

## How to create a Service Principal for use in Terraform Cloud

1. Create Service Principal

    ```bash
    az login

    az account list

    az account set --subscription ${SUBSCRIPTION_ID}

    az ad sp create-for-rbac --name Terraform \
                             --role Contributor \
                             --scopes /subscriptions/${SUBSCRIPTION_ID}
    ```

2. Test Service Principal
    * Extract the TENANT_ID from the `az account list` output
    * Obtain the SUBSCRIPTION_ID from the Azure Portal
    * Extract the CLIENT_ID from the `appId` field of the `az ad sp create-for-rbac` output
    * Extract the CLIENT_SECRET from the `password` field of the `az ad sp create-for-rbac` output

    ```bash
    az login --service-principal \
             --tenant ${TENANT_ID} \
             --user ${CLIENT_ID} \
             --password ${CLIENT_SECRET}

    az vm list-sizes --location westus -o table

    az logout
    ```

## Links

I used the following example as the starting point for this example

* [Quickstart: Configure a Linux virtual machine in Azure using Terraform](https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure)