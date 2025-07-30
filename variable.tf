variable "rg_name" {
  description = "list of resource group"
  type        = list(string)
  default     = ["RG1", "RG2", "RG3", "RG4", "RG5"]
}