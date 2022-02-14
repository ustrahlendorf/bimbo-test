module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = local.base_name
  cidr = "10.10.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.101.0/24", "10.10.102.0/24"]
  intra_subnets   = ["10.10.111.0/24", "10.10.112.0/24"]

  public_subnet_suffix  = "ConPubSub"
  private_subnet_suffix = "AppPrivSub"
  intra_subnet_suffix   = "DataPrivSub"

  public_subnet_tags  = { Name = "ConPubSub-${module.vpc.name}", tier = "public" }
  private_subnet_tags = { Name = "AppPrivSub-${module.vpc.name}", tier = "private" }
  intra_subnet_tags   = { Name = "DataPrivSub-${module.vpc.name}", tier = "protected" }

  public_route_table_tags  = { Name = "ConPubRT-${module.vpc.name}" }
  private_route_table_tags = { Name = "AppPrivRT-${module.vpc.name}" }
  intra_route_table_tags   = { Name = "DataPrivRT-${module.vpc.name}" }

  vpc_tags         = { Name = "VPC-${module.vpc.name}" }
  igw_tags         = { Name = "IGW-${module.vpc.name}" }
  nat_gateway_tags = { Name = "NATGW-${module.vpc.name}" }
  nat_eip_tags     = { Name = "EIP-NATGW-${module.vpc.name}" }

  #  manage_default_route_table = true
  #  default_route_table_tags   = { Name = "default-${module.vpc.name}" }
  #
  #  manage_default_security_group = true
  #  default_security_group_tags   = { Name = "default-${module.vpc.name}" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false

  enable_vpn_gateway = false

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  # enable_flow_log                      = false
  # create_flow_log_cloudwatch_log_group = false
  # create_flow_log_cloudwatch_iam_role  = false
  # flow_log_max_aggregation_interval    = 60
  # vpc_flow_log_tags                    = { Name = "flow_log-${module.vpc.name}" }

  tags = local.default_tags
}

resource "aws_flow_log" "this" {
  iam_role_arn             = aws_iam_role.vpc_flow_log_cloudwatch.arn
  log_destination          = aws_cloudwatch_log_group.example.arn
  traffic_type             = "ALL"
  vpc_id                   = module.vpc.vpc_id
  max_aggregation_interval = 60
  tags                     = local.default_tags
}

resource "aws_cloudwatch_log_group" "example" {
  name = "example"
}


