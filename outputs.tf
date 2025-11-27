output "id" {
  description = "Instance ID"
  value       = try(huaweicloud_compute_instance.this[0].id, null)
}

output "name" {
  description = "Instance name"
  value       = try(huaweicloud_compute_instance.this[0].name, null)
}

output "status" {
  description = "Instance status"
  value       = try(huaweicloud_compute_instance.this[0].status, null)
}

output "private_ip" {
  description = "Private IP address"
  value       = try(huaweicloud_compute_instance.this[0].access_ip_v4, null)
}

output "network_interfaces" {
  description = "Network interfaces"
  value       = try(huaweicloud_compute_instance.this[0].network, [])
}

output "system_disk_id" {
  description = "System disk ID"
  value       = try(huaweicloud_compute_instance.this[0].system_disk_id, null)
}

output "volume_attached" {
  description = "List of attached volumes"
  value       = try(huaweicloud_compute_instance.this[0].volume_attached, [])
}

output "eip_id" {
  description = "EIP ID"
  value       = try(huaweicloud_vpc_eip.this[0].id, null)
}

output "eip_address" {
  description = "EIP address"
  value       = try(huaweicloud_vpc_eip.this[0].address, null)
}

output "public_ip" {
  description = "Public IP address (EIP address)"
  value       = try(huaweicloud_vpc_eip.this[0].address, null)
}

output "eip_bandwidth_id" {
  description = "EIP bandwidth ID"
  value       = try(huaweicloud_vpc_eip.this[0].bandwidth[0].id, null)
}
