output "ecs_id" {
  description = "ECS instance ID"
  value       = module.ecs.id
}

output "ecs_private_ip" {
  description = "ECS private IP"
  value       = module.ecs.private_ip
}

output "ecs_public_ip" {
  description = "ECS public IP (EIP)"
  value       = module.ecs.public_ip
}

output "ecs_status" {
  description = "ECS status"
  value       = module.ecs.status
}

