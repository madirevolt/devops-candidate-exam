resource "aws_subnet" "SubnetDevops" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.40.0/24"
}

data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/code/API.py" 
  output_path = "API.zip"
}

resource "aws_route_table" "my_route_table" {
  vpc_id = data.aws_vpc.vpc.id

  # Add a route to the Internet Gateway (assuming it exists)

}

resource "aws_lambda_function" "lambda_function" {
  function_name = "DevOps-Candidate-Lambda"
  filename      = "API.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role          = data.aws_iam_role.lambda.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 10
}