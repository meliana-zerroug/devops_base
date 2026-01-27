output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = module.sample_apps[*].instance_id
}

output "public_ips" {
  description = "The public IPs of the EC2 instances"
  # Pareil pour les IPs
  value       = module.sample_apps[*].public_ip
}