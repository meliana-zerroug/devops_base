provider "aws" {
  region = "us-east-2"
}

module "sample_apps" {
  source = "../../modules/ec2-instance"

  # on fait une boucle pour ne pas répeter le code 
  count = 2 
  # TODO: fill in with your own AMI ID!
  ami_id = "ami-0ba707486e16be05a"

  name = "sample-app-tofu-${count.index}"
}
