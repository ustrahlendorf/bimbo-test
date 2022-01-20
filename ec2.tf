module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]

  tags = local.common_tags
}

resource "aws_instance" "app_server" {
  ami                    = "${var.ami_amznLinux2}"
  instance_type          = var.appServer_instance_type
  subnet_id              = "${module.vpc.private_subnets[0]}"
  vpc_security_group_ids = ["${module.web_server_sg.security_group_id}"]

  tags =  merge(
    local.common_tags,{
    Name = var.instance_name
    })
}


