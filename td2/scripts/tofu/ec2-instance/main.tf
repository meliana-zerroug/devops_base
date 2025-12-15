#Exercice 7 
# Lorsque l'on run une fois de plus tofu apply, juste après tofu destroy, opentofu va recréer toutes les ressources à partir de 0

#Exercice 8 
# nous avons rajouté l'option count qui agit comme une boucle,
# il permet de définir combien de fois la ressource doit être créee
# et nous avons modifié output pour qu'il prenne en compte la liste d'IDs 


provider "aws" {                                               
  region = "us-east-2"
}

resource "aws_security_group" "sample_app" {                   
  name        = "sample-app-tofu"
  description = "Allow HTTP traffic into the sample app"
}

resource "aws_security_group_rule" "allow_http_inbound" {      
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8080
  to_port           = 8080
  security_group_id = aws_security_group.sample_app.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "sample_app" {  
  # pour plusieurs instances 
  count                  = 3                       
  ami                    = var.ami_id                          
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sample_app.id]
  user_data              = file("${path.module}/user-data.sh") 

  tags = {
    Name = "sample-app-tofu"
    Test = "update"
  }

}
