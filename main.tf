resource "aws_subnet" "SubnetDevops" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "SGDevops" {
  name_prefix = "DevopsCandidate-sg"
  vpc_id = data.aws_vpc.vpc.id
 
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
 
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/code/API.py" 
  output_path = "API.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "DevOps-Candidate-Lambda"
  filename      = "API.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role          = data.aws_iam_role.lambda.arn
  runtime       = "python3.6"
  handler       = "lambda_function.lambda_handler"
  timeout       = 10
  vpc_config {
    subnet_ids = [aws_subnet.SubnetDevops.id]
    security_group_ids = [aws_security_group.SGDevops.id]
  }
}