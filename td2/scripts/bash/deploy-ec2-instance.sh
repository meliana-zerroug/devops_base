#!/usr/bin/env bash

#Exercice 1 
# Lorsque l'on exécute le script une deuxième fois, il plante dès le début. 
# En effet, la commande aws ec2 create-security-group tente de créer un groupe de sécurité avec un nom déjà existant, ce qui provoque une erreur.


# Exercice 2 
# Pour déployer plusieurs instances EC2 avec un script bash nous avons effectué plusieurs modifications, tout d'abord nous avons 
# ajouté l'option --count 2 à la commande aws ec2 run-instances pour lancer deux instances au lieu d'une seule.
# Ensuite, nous avons modifié la requête de sortie pour récupérer les IDs de toutes les instances lancées en utilisant 'Instances[*].InstanceId' au lieu de 'Instances[0].InstanceId'.
# Enfin, nous avons juste enlevé les doubles quotes autour de $instance_id dans la commande aws ec2 describe-instances pour permettre la gestion de plusieurs IDs.

# Voici la preuve que ça a fonctionné, nous avons obtenu ceci : 
#Instance ID = i-0465975415b7d51c5       i-0f769791ed6c4a716
#Security Group ID = sg-08433f54cc0f1c616
#Public IP = 3.144.79.86 3.134.103.150

set -e

export AWS_DEFAULT_REGION="us-east-2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
user_data=$(cat "$SCRIPT_DIR/user-data.sh")

security_group_id=$(aws ec2 create-security-group \
  --group-name "sample-appv4" \
  --description "Allow HTTP traffic into the sample app" \
  --output text \
  --query GroupId)

aws ec2 authorize-security-group-ingress \
  --group-id "$security_group_id" \
  --protocol tcp \
  --port 80 \
  --cidr "0.0.0.0/0" > /dev/null

instance_id=$(aws ec2 run-instances \
  --image-id "ami-0900fe555666598a2" \
  --instance-type "t3.micro" \
  --count 2 \
  --security-group-ids "$security_group_id" \
  --user-data "$user_data" \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=sample-app}]' \
  --output text \
  --query Instances[*].InstanceId)

public_ip=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --output text \
  --query 'Reservations[*].Instances[*].PublicIpAddress')

echo "Instance ID = $instance_id"
echo "Security Group ID = $security_group_id"
echo "Public IP = $public_ip"
