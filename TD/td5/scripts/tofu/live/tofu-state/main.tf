provider "aws" {
  region = "us-east-2"
}

module "state" {
  source = "github.com/meliana-zerroug/devops_base//TD/td5/modules/state-bucket"

  # TODO: fill in your own bucket name!
  name = "meliana-zerroug-devops-tofu-state"
}