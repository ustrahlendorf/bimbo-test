resource "aws_iam_role" "SsmEC2Role" {
  path = "/"
  name = "EC2RoleForSsm"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  max_session_duration = 3600
  tags                 = local.default_tags
}

resource "aws_iam_role_policy_attachment" "SsmPolicyToSsmRole" {
  role       = aws_iam_role.SsmEC2Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "SsmEC2Profile" {
  path = "/"
  name = "SsmEC2InstanceProfile"
  role = aws_iam_role.SsmEC2Role.name
  tags = local.default_tags
}

resource "aws_iam_policy" "vpc_flow_log_cloudwatch" {
  name_prefix = "vpc-flow-log-to-cloudwatch-"
  path        = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSVPCFlowLogsPushToCloudWatch"
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream"
        ],
        Resource = "*"
      }
    ]
  })

  tags = local.default_tags
}

resource "aws_iam_role" "vpc_flow_log_cloudwatch" {
  name_prefix = "vpc_flow_log_cloudwatch-"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AWSVPCFlowLogsAssumeRole"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })
  tags = local.default_tags
}
resource "aws_iam_role_policy_attachment" "vpc_flow_log_cloudwatch" {
  role       = aws_iam_role.vpc_flow_log_cloudwatch.name
  policy_arn = aws_iam_policy.vpc_flow_log_cloudwatch.arn
}
