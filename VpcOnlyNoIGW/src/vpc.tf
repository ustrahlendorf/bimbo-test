module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "my-tf-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]

  public_subnet_suffix  = "pubSub"
  private_subnet_suffix = "privSub"

  private_subnet_tags = { Name = "privSub-${module.vpc.name}" }
  public_subnet_tags = { Name = "pubSub-${module.vpc.name}" }

  private_route_table_tags = { Name = "privRT-${module.vpc.name}" }
  public_route_table_tags = { Name = "pubRT-${module.vpc.name}" }

  manage_default_route_table = true
  default_route_table_tags = { Name = "default-${module.vpc.name}" }
  
  manage_default_security_group = true
  default_security_group_tags   = { Name = "default-${module.vpc.name}" }

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = false

  tags = local.common_tags
}


