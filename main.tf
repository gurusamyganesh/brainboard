resource "aws_vpc" "default" {
  tags       = merge(var.tags, { Name = "BrainboardVPC" })
  cidr_block = var.vpc_cidr
}

resource "aws_route_table_association" "aws_route_table_association_11" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private_a.id
}

resource "aws_route_table_association" "aws_route_table_association_12" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private_b.id
}

resource "aws_route_table_association" "aws_route_table_association_13" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.rt_private_c.id
}

resource "aws_security_group" "brainboard-sg" {
  vpc_id = aws_vpc.default.id
  tags   = merge(var.tags, {})

  egress {
    to_port   = 0
    protocol  = "tcp"
    from_port = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    to_port   = 0
    protocol  = "tcp"
    from_port = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_iam_role" "Brainboard_iam_role" {
  tags = merge(var.tags, { Name = "Brainboard_IAMRole" })
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment_17" {
  role       = aws_iam_role.Brainboard_iam_role.name
  policy_arn = aws_iam_policy.Brainboard_iam_policy.arn

  depends_on = [
    aws_iam_role.Brainboard_iam_role,
    aws_iam_policy.Brainboard_iam_policy,
  ]
}

resource "aws_iam_policy" "Brainboard_iam_policy" {
  tags = merge(var.tags, {})
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
      }, {
      Effect = "Allow"
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      Resource = ["*"]
    }]
  })
}

data "archive_file" "terraform_resource_19" {

  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/testpy.zip"
}

resource "aws_lambda_function" "aws_lambda_function_20" {
  tags          = merge(var.tags, {})
  runtime       = "python3.8"
  role          = aws_iam_role.Brainboard_iam_role.arn
  handler       = "test"
  function_name = "test"
  filename      = "${path.module}/python/test.zip"

  depends_on = [
    aws_iam_role_policy_attachment.aws_iam_role_policy_attachment_17,
  ]
}

