
#Exercice 5 : 
# Si on le run une seconde fois, il crée une deuxième AMI avec succès (doublon de la première)
# Dans notre fichier de configuration, nous utilisons la fonction ${uuidv4()} dans le paramètre ami_name. Cette fonction génère un identifiant aléatoire unique à chaque exécution. Comme le nom change à chaque fois, il n'y a pas de conflit et une nouvelle image est créée.
# voici l'id de l'ami ami-0ba707486e16be05a


# Exercice 6 : 
# Pour adapter le template à un usage local, on a effectué les changements suivant (le code est dans sample-app-multi.pkr.hcl) 

packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon_linux" {                  
  ami_name        = "sample-app-packer-${uuidv4()}"
  ami_description = "Amazon Linux 2023 AMI with a Node.js sample app."
  instance_type   = "t3.micro"
  region          = "us-east-2"
  source_ami      = "ami-0900fe555666598a2"
  ssh_username    = "ec2-user"
}

build {                                               
  sources = ["source.amazon-ebs.amazon_linux"]

  provisioner "file" {                                
    source      = "app.js"
    destination = "/home/ec2-user/app.js"
  }

  provisioner "shell" {                               
    inline = [
      "curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -",
      "sudo yum install -y nodejs"
    ]
    pause_before = "30s"
  }
}