data "aws_availability_zones" "current" {}

data "aws_region" "current" {}

#data "aws_vpc" "this" {
#  tags = {
#    Name = var.base_name
#  }
#}
#
#data "aws_subnet_ids" "public" {
#  vpc_id = data.aws_vpc.this.id
#  tags = {
#    tier = "public"
#  }
#}
