resource "aws_api_gateway_rest_api" "example" {
  name        = "ServerlessExample"
  description = "Terraform Serverless Application Example"
}

resource "aws_api_gateway_resource" "deploy" {
   rest_api_id = aws_api_gateway_rest_api.example.id
   parent_id   = aws_api_gateway_rest_api.example.root_resource_id
   path_part   = "deploy"
}

resource "aws_api_gateway_method" "deploy" {
   rest_api_id   = aws_api_gateway_rest_api.example.id
   resource_id   = aws_api_gateway_resource.deploy.id
   http_method   = "ANY"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.example.id
   resource_id = aws_api_gateway_method.deploy.resource_id
   http_method = aws_api_gateway_method.deploy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_deployment" "example" {
   depends_on = [
     aws_api_gateway_integration.lambda,
   ]

   rest_api_id = aws_api_gateway_rest_api.example.id
   stage_name  = "test"
}