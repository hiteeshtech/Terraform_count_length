# Terraform_count_length

In this task given to us are to make 5 Nos. resource group having same location and name should be different. So, we have write the code as 

variable "rg_name" {
  description = "list of resource group"
  type        = list(string)
  default     = ["RG1", "RG2", "RG3", "RG4", "RG5"]
}

then when we will write the command terraform plan then the result came out in this way 
PS D:\hiteesh_terraform\Terraform_count_length> terraform plan 
azurerm_resource_group.rg[4]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG5]
azurerm_resource_group.rg[3]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG4]
azurerm_resource_group.rg[0]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG1]
azurerm_resource_group.rg[1]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG2]
azurerm_resource_group.rg[2]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG3]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:   

  # azurerm_resource_group.rg[0] will be created
  + resource "azurerm_resource_group" "rg" {    
      + id       = (known after apply)
      + location = "eastus"
      + name     = "RG1"
    }

  # azurerm_resource_group.rg[1] will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "RG2"
    }

  # azurerm_resource_group.rg[2] will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "RG3"
    }

  # azurerm_resource_group.rg[3] will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "RG4"
    }

  # azurerm_resource_group.rg[4] will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "RG5"
    }

Plan: 5 to add, 0 to change, 0 to destroy.
So as you can see that all the 5 nos. resource group made with all serial number wise 

If RG3 is deleted then what happen lets see 

variable "rg_name" {
  description = "list of resource group"
  type        = list(string)
  default     = ["RG1", "RG2", "RG4", "RG5"]
}

PS D:\hiteesh_terraform\Terraform_count_length> terraform fmt
PS D:\hiteesh_terraform\Terraform_count_length> terraform plan 
azurerm_resource_group.rg[3]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG4]
azurerm_resource_group.rg[1]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG2]
azurerm_resource_group.rg[2]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG3]
azurerm_resource_group.rg[0]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG1]
azurerm_resource_group.rg[4]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG5]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # azurerm_resource_group.rg[2] must be replaced
-/+ resource "azurerm_resource_group" "rg" {
      ~ id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG3" -> (known after apply)
      ~ name       = "RG3" -> "RG4" # forces replacement
      - tags       = {} -> null
        # (2 unchanged attributes hidden)
    }

  # azurerm_resource_group.rg[3] must be replaced
-/+ resource "azurerm_resource_group" "rg" {
      ~ id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG4" -> (known after apply)
      ~ name       = "RG4" -> "RG5" # forces replacement
      - tags       = {} -> null
        # (2 unchanged attributes hidden)
    }

  # azurerm_resource_group.rg[4] will be destroyed
  # (because index [4] is out of range for count)
  - resource "azurerm_resource_group" "rg" {
      - id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG5" -> null
      - location   = "eastus" -> null
      - name       = "RG5" -> null
        # (1 unchanged attribute hidden)
    }

Plan: 2 to add, 0 to change, 3 to destroy.

Now they will destroy three RG first and then again it will create 2 RG 

Now we will delete RG2 then what happens lets see 

variable "rg_name" {
  description = "list of resource group"
  type        = list(string)
  default     = ["RG1", "RG4", "RG5"]
}


PS D:\hiteesh_terraform\Terraform_count_length> terraform plan 
azurerm_resource_group.rg[0]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG1]
azurerm_resource_group.rg[1]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG2]
azurerm_resource_group.rg[2]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG4]
azurerm_resource_group.rg[3]: Refreshing state... [id=/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG5]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # azurerm_resource_group.rg[1] must be replaced
-/+ resource "azurerm_resource_group" "rg" {
      ~ id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG2" -> (known after apply)
      ~ name       = "RG2" -> "RG4" # forces replacement
      - tags       = {} -> null
        # (2 unchanged attributes hidden)
    }

  # azurerm_resource_group.rg[2] must be replaced
-/+ resource "azurerm_resource_group" "rg" {
      ~ id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG4" -> (known after apply)
      ~ name       = "RG4" -> "RG5" # forces replacement
      - tags       = {} -> null
        # (2 unchanged attributes hidden)
    }

  # azurerm_resource_group.rg[3] will be destroyed
  # (because index [3] is out of range for count)
  - resource "azurerm_resource_group" "rg" {
      - id         = "/subscriptions/f96f2e3b-2cc8-4e5e-8ed9-4afb664bb5a8/resourceGroups/RG5" -> null
      - location   = "eastus" -> null
      - name       = "RG5" -> null
      - tags       = {} -> null
        # (1 unchanged attribute hidden)
    }

Plan: 2 to add, 0 to change, 3 to destroy.

So here first terraform is going to delete 3 RG and then they will again create 2 RG 

