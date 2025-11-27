variable "create" {
  description = "Whether to create ECS instance"
  type        = bool
  default     = true
}

variable "region" {
  description = "Huawei Cloud region"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the ECS instance"
  type        = string
}

variable "image_id" {
  description = "ID of the image to use for the instance"
  type        = string
}

variable "flavor_id" {
  description = "Flavor ID (instance type)"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = null
}

variable "key_pair_name" {
  description = "Name of the key pair to use"
  type        = string
  default     = null
}

variable "system_disk_type" {
  description = "System disk type (SSD, GPSSD, SAS, SATA)"
  type        = string
  default     = "SSD"
}

variable "system_disk_size" {
  description = "System disk size in GB"
  type        = number
  default     = 40
}

variable "network_ids" {
  description = "List of network configurations"
  type = list(object({
    uuid              = string
    fixed_ip_v4       = optional(string)
    ipv6_enable       = optional(bool)
    source_dest_check = optional(bool)
    access_network    = optional(bool)
  }))
  default = []
}

variable "data_disks" {
  description = "List of data disks to attach"
  type = list(object({
    type = string
    size = number
  }))
  default = []
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = null
}

variable "admin_pass" {
  description = "Admin password"
  type        = string
  default     = null
  sensitive   = true
}

variable "enterprise_project_id" {
  description = "Enterprise project ID"
  type        = string
  default     = null
}

variable "stop_before_destroy" {
  description = "Whether to stop instance before destroying"
  type        = bool
  default     = true
}

variable "delete_disks_on_termination" {
  description = "Whether to delete disks on termination"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_eip" {
  description = "Whether to create an EIP"
  type        = bool
  default     = false
}

variable "associate_eip" {
  description = "Whether to associate EIP with the instance"
  type        = bool
  default     = true
}

variable "eip_name" {
  description = "Name of the EIP"
  type        = string
  default     = null
}

variable "eip_type" {
  description = "EIP type"
  type        = string
  default     = "5_bgp"
}

variable "eip_bandwidth_share_type" {
  description = "Bandwidth share type (PER or WHOLE)"
  type        = string
  default     = "PER"
}

variable "eip_bandwidth_name" {
  description = "Name of the bandwidth"
  type        = string
  default     = null
}

variable "eip_bandwidth_size" {
  description = "Bandwidth size in Mbps"
  type        = number
  default     = 10
}

variable "eip_bandwidth_charge_mode" {
  description = "Bandwidth charge mode (traffic or bandwidth)"
  type        = string
  default     = "traffic"
}

variable "eip_tags" {
  description = "Additional tags for EIP"
  type        = map(string)
  default     = {}
}

variable "volume_attachments" {
  description = "Map of volume attachments"
  type = map(object({
    volume_id = string
    device    = optional(string)
  }))
  default = {}
}

