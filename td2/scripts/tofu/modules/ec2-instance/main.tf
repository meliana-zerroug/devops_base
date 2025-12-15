# voici ce que l'on obtient avec count : 
#Apply complete! Resources: 6 added, 0 changed, 0 destroyed.     

#Outputs:

#instance_ids = [
#  "i-03cb509be3326b7cc",
#  "i-09637460145e81f4e",
#]
#public_ips = [
#  "3.142.97.139",
#  "18.188.71.57",
#]


resource "aws_security_group" "sample_app" {
  name        = var.name
  description = "Allow HTTP traffic into ${var.name}"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.http_port
  to_port           = var.http_port
  security_group_id = aws_security_group.sample_app.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "sample_app" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sample_app.id]
  user_data              = file("${path.module}/user-data.sh")

  tags = {
    Name = var.name
  }
}
