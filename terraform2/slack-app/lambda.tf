data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "../src/lambda_function/deploy/lambda.py"
    output_path   = "../archive/deploy.zip"
}

resource "aws_lambda_function" "example" {
    function_name    = "ServerlessExample"
    filename         = "../archive/deploy.zip"
    role             = aws_iam_role.lambda_exec.arn
    handler          = "lambda.handler"
    runtime          = "python3.6"
}

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.example.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}