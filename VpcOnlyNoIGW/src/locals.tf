locals {
  region = data.aws_region.current
  azs    = data.aws_availability_zones.current

  team        = var.base_name
  Terraform   = true
  environment = "dev"

  default_tags = {
    team        = local.team
    environment = local.environment
    Terraform   = local.Terraform
  }
}
