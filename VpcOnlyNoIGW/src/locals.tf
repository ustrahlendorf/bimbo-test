locals {
  base_name = var.app_name

  Terraform   = true
  environment = "dev"

  default_tags = {
    environment = local.environment
    Terraform   = local.Terraform
  }
}
