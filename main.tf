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

resource "aws_lambda_function" "aws_lambda_function_14" {
  tags          = merge(var.tags, {})
  runtime       = "Phyton3.8"
  role          = aws_iam_role.lambda_role.arn
  handler       = "test.lambda_handler"
  function_name = "restapi_py"
  filename      = "${path.module}/python/testpy.zip"

  depends_on = [
    aws_iam_role_policy_attachment.aws_iam_role_policy_attachment_17,
  ]
}

resource "aws_iam_policy" "aws_iam_policy_15" {
  tags   = merge(var.tags, {})
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  name   = "lambda_role"
}

resource "aws_iam_policy" "aws_iam_policy_16" {
  tags   = merge(var.tags, {})
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
  path   = "/"
  name   = "iam_policy_for_lambda"
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment_17" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "lambda_archive" "terraform_resource_18" {

  data "archive_file" "zip_the_python_code" {
    type        = "zip"
    source_dir  = "${path.module}/python/"
    output_path = "${path.module}/python/hello-python.zip"
  }
}

