resource "huaweicloud_compute_instance" "this" {
  count = var.create ? 1 : 0

  name               = var.name
  image_id           = var.image_id
  flavor_id          = var.flavor_id
  security_group_ids = var.security_group_ids
  availability_zone  = var.availability_zone
  key_pair           = var.key_pair_name

  system_disk_type = var.system_disk_type
  system_disk_size = var.system_disk_size

  dynamic "network" {
    for_each = var.network_ids
    content {
      uuid              = network.value.uuid
      fixed_ip_v4       = try(network.value.fixed_ip_v4, null)
      ipv6_enable       = try(network.value.ipv6_enable, null)
      source_dest_check = try(network.value.source_dest_check, null)
      access_network    = try(network.value.access_network, false)
    }
  }

  dynamic "data_disks" {
    for_each = var.data_disks
    content {
      type = data_disks.value.type
      size = data_disks.value.size
    }
  }

  user_data                   = var.user_data
  admin_pass                  = var.admin_pass
  enterprise_project_id       = var.enterprise_project_id
  stop_before_destroy         = var.stop_before_destroy
  delete_disks_on_termination = var.delete_disks_on_termination

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )
}

resource "huaweicloud_vpc_eip" "this" {
  count = var.create && var.create_eip ? 1 : 0

  name   = var.eip_name != null ? var.eip_name : "${var.name}-eip"
  region = var.region

  publicip {
    type = var.eip_type
  }

  bandwidth {
    share_type  = var.eip_bandwidth_share_type
    name        = var.eip_bandwidth_name != null ? var.eip_bandwidth_name : "${var.name}-bandwidth"
    size        = var.eip_bandwidth_size
    charge_mode = var.eip_bandwidth_charge_mode
  }

  enterprise_project_id = var.enterprise_project_id

  tags = merge(
    { "Name" = var.eip_name != null ? var.eip_name : "${var.name}-eip" },
    var.tags,
    var.eip_tags,
  )
}

resource "huaweicloud_compute_eip_associate" "this" {
  count = var.create && var.create_eip && var.associate_eip ? 1 : 0

  public_ip   = huaweicloud_vpc_eip.this[0].address
  instance_id = huaweicloud_compute_instance.this[0].id
}

resource "huaweicloud_compute_volume_attach" "this" {
  for_each = var.create ? var.volume_attachments : {}

  instance_id = huaweicloud_compute_instance.this[0].id
  volume_id   = each.value.volume_id
  device      = try(each.value.device, null)
}
