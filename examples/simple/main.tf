provider "huaweicloud" {
  region = local.region
}

data "huaweicloud_availability_zones" "available" {}

data "huaweicloud_images_image" "ubuntu" {
  name        = "Ubuntu 22.04 server 64bit"
  most_recent = true
}

locals {
  region = "tr-west-1"
  name   = "example-ecs"
}

################################################################################
# ECS Module - Basit örnek
################################################################################

module "ecs" {
  source = "../../"

  name              = local.name
  image_id          = data.huaweicloud_images_image.ubuntu.id
  flavor_id         = "s6.small.1"
  availability_zone = data.huaweicloud_availability_zones.available.names[0]

  network_ids = [
    {
      uuid = "your-subnet-id" # Kendi subnet ID'nizi buraya yazın
    }
  ]

  security_group_ids = ["your-security-group-id"] # Kendi security group ID'nizi buraya yazın

  system_disk_type = "SSD"
  system_disk_size = 40

  tags = {
    Environment = "test"
    Terraform   = "true"
  }
}

