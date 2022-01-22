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
