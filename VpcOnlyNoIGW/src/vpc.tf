module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = "my-tf-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]

  public_subnet_suffix  = "privSub"
  private_subnet_suffix = "pubSub"

  default_security_group_name = "tf-default"

  enable_nat_gateway = false
  single_nat_gateway = false

  enable_vpn_gateway = false

  tags = local.common_tags
}


