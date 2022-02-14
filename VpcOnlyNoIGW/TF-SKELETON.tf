terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_role" "IAMRole" {
  path                 = "/"
  name                 = "SSMforEC2Role"
  assume_role_policy   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  max_session_duration = 3600
  tags {}
}

resource "aws_iam_instance_profile" "IAMInstanceProfile" {
  path = "/"
  name = aws_iam_role.IAMRole.name
  roles = [
    "${aws_iam_role.IAMRole.name}"
  ]
}

resource "aws_iam_policy" "IAMManagedPolicy" {
  name   = "vpc-flow-log-to-cloudwatch-20220210085010548100000001"
  path   = "/"
  policy = "{\"Statement\":[{\"Action\":[\"logs:PutLogEvents\",\"logs:DescribeLogStreams\",\"logs:DescribeLogGroups\",\"logs:CreateLogStream\"],\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"AWSVPCFlowLogsPushToCloudWatch\"}],\"Version\":\"2012-10-17\"}"
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint" {
  vpc_endpoint_type = "Interface"
  vpc_id            = "vpc-0a3ebfad568139d64"
  service_name      = "com.amazonaws.eu-central-1.ssmmessages"
  policy            = <<EOF
{
  "Statement": [
    {
      "Action": "*", 
      "Effect": "Allow", 
      "Principal": "*", 
      "Resource": "*"
    }
  ]
}
EOF
  subnet_ids = [
    "subnet-0122cf64506066aaa",
    "subnet-068f7fec970e75b40"
  ]
  private_dns_enabled = true
  security_group_ids = [
    "sg-0dc0aed33ee8d67d2",
    "sg-037fca3243b0ae2da"
  ]
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint2" {
  vpc_endpoint_type = "Interface"
  vpc_id            = "vpc-0a3ebfad568139d64"
  service_name      = "com.amazonaws.eu-central-1.ec2messages"
  policy            = <<EOF
{
  "Statement": [
    {
      "Action": "*", 
      "Effect": "Allow", 
      "Principal": "*", 
      "Resource": "*"
    }
  ]
}
EOF
  subnet_ids = [
    "subnet-0122cf64506066aaa",
    "subnet-068f7fec970e75b40"
  ]
  private_dns_enabled = true
  security_group_ids = [
    "sg-0dc0aed33ee8d67d2",
    "sg-037fca3243b0ae2da"
  ]
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint3" {
  vpc_endpoint_type = "Interface"
  vpc_id            = "vpc-0a3ebfad568139d64"
  service_name      = "com.amazonaws.eu-central-1.ssm"
  policy            = <<EOF
{
  "Statement": [
    {
      "Action": "*", 
      "Effect": "Allow", 
      "Principal": "*", 
      "Resource": "*"
    }
  ]
}
EOF
  subnet_ids = [
    "subnet-0122cf64506066aaa",
    "subnet-068f7fec970e75b40"
  ]
  private_dns_enabled = true
  security_group_ids = [
    "sg-0dc0aed33ee8d67d2",
    "sg-037fca3243b0ae2da"
  ]
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint4" {
  vpc_endpoint_type = "Gateway"
  vpc_id            = "vpc-0a3ebfad568139d64"
  service_name      = "com.amazonaws.eu-central-1.s3"
  policy            = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"*\",\"Resource\":\"*\"}]}"
  route_table_ids = [
    "rtb-0765525358cfa205a",
    "rtb-0e383b49ba28de00c",
    "rtb-00af5f3f74e32370e",
    "rtb-07580662dee2f1252"
  ]
  private_dns_enabled = false
}

resource "aws_route" "EC2Route" {
  gateway_id     = "vpce-04f936d7968d422a7"
  route_table_id = "rtb-0765525358cfa205a"
}

resource "aws_route_table" "EC2RouteTable" {
  vpc_id = "vpc-0a3ebfad568139d64"
  tags {
    Terraform   = "true"
    Name        = "DataPrivRT-ITPA"
    environment = "dev"
  }
}

resource "aws_route_table" "EC2RouteTable2" {
  vpc_id = "vpc-0a3ebfad568139d64"
  tags {
    environment = "dev"
    Name        = "AppPrivRT-ITPA"
    Terraform   = "true"
  }
}

resource "aws_route_table" "EC2RouteTable3" {
  vpc_id = "vpc-0a3ebfad568139d64"
  tags {}
}

resource "aws_route_table" "EC2RouteTable4" {
  vpc_id = "vpc-0a3ebfad568139d64"
  tags {
    Name        = "ConPubRT-ITPA"
    Terraform   = "true"
    environment = "dev"
  }
}

resource "aws_route_table" "EC2RouteTable5" {
  vpc_id = "vpc-0a3ebfad568139d64"
  tags {
    environment = "dev"
    Name        = "AppPrivRT-ITPA"
    Terraform   = "true"
  }
}


---------------------------
 # module.vpc.aws_flow_log.this[0] must be replaced
-/+ resource "aws_flow_log" "this" {
      ~ arn                      = "arn:aws:ec2:eu-central-1:738155121896:vpc-flow-log/fl-0a61f075ef713bd90" -> (known after apply)
      - iam_role_arn             = "arn:aws:iam::738155121896:role/vpc-flow-log-role-20220214080746931700000002" -> null # forces replacement
      ~ id                       = "fl-0a61f075ef713bd90" -> (known after apply)
      ~ log_format               = "${version} ${account-id} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status}" -> (known after apply)
      ~ log_group_name           = "/aws/vpc-flow-log/vpc-07d09d37a8656fda9" -> (known after apply)
        tags                     = {
            "Name"        = "flow_log-ITPA"
            "Terraform"   = "true"
            "environment" = "dev"
        }
        # (6 unchanged attributes hidden)
    }

  # module.vpc.aws_iam_policy.vpc_flow_log_cloudwatch[0] will be destroyed
  # (because index [0] is out of range for count)
  - resource "aws_iam_policy" "vpc_flow_log_cloudwatch" {
      - arn         = "arn:aws:iam::738155121896:policy/vpc-flow-log-to-cloudwatch-20220214080746931400000001" -> null
      - id          = "arn:aws:iam::738155121896:policy/vpc-flow-log-to-cloudwatch-20220214080746931400000001" -> null
      - name        = "vpc-flow-log-to-cloudwatch-20220214080746931400000001" -> null
      - name_prefix = "vpc-flow-log-to-cloudwatch-" -> null
      - path        = "/" -> null
      - policy      = jsonencode(
            {
              - Statement = [
                  - {
                      - Action   = [
                          - "logs:PutLogEvents",
                          - "logs:DescribeLogStreams",
                          - "logs:DescribeLogGroups",
                          - "logs:CreateLogStream",
                        ]
                      - Effect   = "Allow"
                      - Resource = "*"
                      - Sid      = "AWSVPCFlowLogsPushToCloudWatch"
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - policy_id   = "ANPA2XXLZJTUEV375ZPUJ" -> null
      - tags        = {
          - "Name"        = "flow_log-ITPA"
          - "Terraform"   = "true"
          - "environment" = "dev"
        } -> null
      - tags_all    = {
          - "Name"        = "flow_log-ITPA"
          - "Terraform"   = "true"
          - "environment" = "dev"
        } -> null
    }

  # module.vpc.aws_iam_role.vpc_flow_log_cloudwatch[0] will be destroyed
  # (because index [0] is out of range for count)
  - resource "aws_iam_role" "vpc_flow_log_cloudwatch" {
      - arn                   = "arn:aws:iam::738155121896:role/vpc-flow-log-role-20220214080746931700000002" -> null
      - assume_role_policy    = jsonencode(
            {
              - Statement = [
                  - {
                      - Action    = "sts:AssumeRole"
                      - Effect    = "Allow"
                      - Principal = {
                          - Service = "vpc-flow-logs.amazonaws.com"
                        }
                      - Sid       = "AWSVPCFlowLogsAssumeRole"
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - create_date           = "2022-02-14T08:07:48Z" -> null
      - force_detach_policies = false -> null
      - id                    = "vpc-flow-log-role-20220214080746931700000002" -> null
      - managed_policy_arns   = [
          - "arn:aws:iam::738155121896:policy/vpc-flow-log-to-cloudwatch-20220214080746931400000001",
        ] -> null
      - max_session_duration  = 3600 -> null
      - name                  = "vpc-flow-log-role-20220214080746931700000002" -> null
      - name_prefix           = "vpc-flow-log-role-" -> null
      - path                  = "/" -> null
      - tags                  = {
          - "Name"        = "flow_log-ITPA"
          - "Terraform"   = "true"
          - "environment" = "dev"
        } -> null
      - tags_all              = {
          - "Name"        = "flow_log-ITPA"
          - "Terraform"   = "true"
          - "environment" = "dev"
        } -> null
      - unique_id             = "AROA2XXLZJTUI6VDUW44A" -> null

      - inline_policy {}
    }

  # module.vpc.aws_iam_role_policy_attachment.vpc_flow_log_cloudwatch[0] will be destroyed
  # (because index [0] is out of range for count)
  - resource "aws_iam_role_policy_attachment" "vpc_flow_log_cloudwatch" {
      - id         = "vpc-flow-log-role-20220214080746931700000002-20220214080749612700000003" -> null
      - policy_arn = "arn:aws:iam::738155121896:policy/vpc-flow-log-to-cloudwatch-20220214080746931400000001" -> null
      - role       = "vpc-flow-log-role-20220214080746931700000002" -> null
    }

Plan: 1 to add, 0 to change, 4 to destroy.