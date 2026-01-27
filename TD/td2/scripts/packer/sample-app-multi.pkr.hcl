#code a remplacé à la place de sample-app pour un usage local (VirtualBox)


packer {
  required_plugins {
    # 1. On change le plugin requis
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

# 2. On change le type de source : "virtualbox-iso" au lieu de "amazon-ebs"
source "virtualbox-iso" "ubuntu_local" {
  vm_name      = "sample-app-local"
  cpus         = 2
  memory       = 1024

  # 3. Au lieu d'une AMI, on utilise une URL vers un fichier ISO (CD d'install)
  iso_url      = "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
  # On doit donner le code de vérification du fichier (Checksum) pour la sécurité
  iso_checksum = "md5:b8f31413336b9393ad5d8ef0282717b2"

  # Configuration SSH pour se connecter à la VM locale
  ssh_username = "user"
  ssh_password = "password"
  
  # Commande automatique pour installer l'OS sans toucher au clavier (Spécifique VirtualBox)
  boot_command = [
    "<enter><wait><enter><wait><f6><wait><esc><wait>",
    "install auto=true priority=critical",
    "<enter>"
  ]
}

build {
  sources = ["source.virtualbox-iso.ubuntu_local"]

  provisioner "file" {
    source      = "app.js"
    destination = "/home/user/app.js"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nodejs"
    ]
  }
}