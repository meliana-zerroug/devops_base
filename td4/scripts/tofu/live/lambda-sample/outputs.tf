output "api_endpoint" {
  description = "REST API endpoint for the Lambda function"
  value       = "${aws_api_gateway_stage.stage.invoke_url}"
}
