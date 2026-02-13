provider "aws" {
  region = "us-east-2"
}

module "function" {
  source = "github.com/meliana-zerroug/devops_base//td3/scripts/tofu/modules/lambda"

  name = "lambda-sample"         

  src_dir = "${path.module}/src" 
  runtime = "nodejs20.x"   
  #runtime = "python3.12"      
  handler = "index.handler"      

  memory_size = 128              
  timeout     = 5                

  environment_variables = {      
    NODE_ENV = "production"
  }

}

module "gateway" {
  source = "github.com/meliana-zerroug/devops_base//td3/scripts/tofu/modules/api-gateway"

  name               = "lambda-sample"              
  function_arn       = module.function.function_arn 
  api_gateway_routes = ["GET /", "POST /data"]                    
}
