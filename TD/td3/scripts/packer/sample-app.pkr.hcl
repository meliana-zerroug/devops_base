packer { 
  required_plugins { 
    amazon = { 
      version = ">= 1.0.0" 
      source  = "github.com/hashicorp/amazon" 
    } 
  } 
} 
variable "aws_region" { 
  type    = string 
  default = "us-east-2" 
} 
source "amazon-ebs" "amazon_linux" { 
  ami_name      = "packer-sample-app-{{timestamp}}" 
  instance_type = "t3.micro" 
  region        = var.aws_region 
  source_ami_filter {
    filters = { 
      name                = "al2023-ami-*-x86_64" 
      root-device-type    = "ebs" 
      virtualization-type = "hvm" 
    } 
    owners      = ["amazon"] 
    most_recent = true 
  } 
  ssh_username = "ec2-user" 
} 
build { 
  sources = ["source.amazon-ebs.amazon_linux"] 
  provisioner "file" { 
    sources      = ["app.js", "app.config.js"] 
    destination  = "/tmp/" 
  } 
  provisioner "shell" { 
    inline = [ 
      "sudo yum update -y", 
      "curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -", 
      "sudo yum install -y nodejs", 
      "sudo useradd app-user", 
      "sudo mkdir -p /home/app-user", 
      "sudo mv /tmp/app.js /tmp/app.config.js /home/app-user/", 
      "sudo chown -R app-user:app-user /home/app-user", 
      "sudo npm install pm2@latest -g", 
      "sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u app-user --hp /home/app-user", 
      "sudo systemctl enable pm2-app-user", 
    ] 
  } 
}
