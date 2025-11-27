# Huawei Cloud ECS Terraform Module

Bu modül Huawei Cloud'da ECS (Elastic Cloud Server) instance'ları oluşturmak için kullanılır.

## Özellikler

- ✅ ECS instance oluşturma
- ✅ EIP (Elastic IP) oluşturma ve bağlama (opsiyonel)
- ✅ Birden fazla network interface desteği
- ✅ Data disk desteği
- ✅ Volume attachment desteği
- ✅ User data desteği
- ✅ Enterprise project desteği
- ✅ Esnek ve özelleştirilebilir

## Kullanım

### Basit Örnek

```hcl
module "ecs" {
  source = "./terraform-huawei-ecs"

  name              = "my-ecs-instance"
  image_id          = "your-image-id"
  flavor_id         = "s6.small.1"
  security_group_ids = ["sg-xxxxx"]
  availability_zone = "tr-west-1a"
  key_pair_name     = "my-keypair"

  network_ids = [
    {
      uuid = "subnet-id"
    }
  ]

  tags = {
    Environment = "production"
    Project     = "myproject"
  }
}
```

### EIP ile Örnek

```hcl
module "ecs" {
  source = "./terraform-huawei-ecs"

  name              = "my-ecs-instance"
  image_id          = "your-image-id"
  flavor_id         = "s6.small.1"
  security_group_ids = ["sg-xxxxx"]
  availability_zone = "tr-west-1a"
  key_pair_name     = "my-keypair"

  network_ids = [
    {
      uuid = "subnet-id"
    }
  ]

  # EIP oluştur ve bağla
  create_eip           = true
  eip_bandwidth_size   = 10
  eip_bandwidth_charge_mode = "traffic"

  tags = {
    Environment = "production"
  }
}
```

### Data Disk ile Örnek

```hcl
module "ecs" {
  source = "./terraform-huawei-ecs"

  name              = "my-ecs-instance"
  image_id          = "your-image-id"
  flavor_id         = "s6.medium.2"
  security_group_ids = ["sg-xxxxx"]
  availability_zone = "tr-west-1a"
  key_pair_name     = "my-keypair"

  network_ids = [
    {
      uuid = "subnet-id"
    }
  ]

  # Data diskler ekle
  data_disks = [
    {
      type = "SSD"
      size = 100
    },
    {
      type = "SSD"
      size = 200
    }
  ]

  tags = {
    Environment = "production"
  }
}
```

### User Data ile Örnek

```hcl
module "ecs" {
  source = "./terraform-huawei-ecs"

  name              = "my-ecs-instance"
  image_id          = "your-image-id"
  flavor_id         = "s6.small.1"
  security_group_ids = ["sg-xxxxx"]
  availability_zone = "tr-west-1a"
  key_pair_name     = "my-keypair"

  network_ids = [
    {
      uuid = "subnet-id"
    }
  ]

  # Başlangıç scripti
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    EOF

  tags = {
    Environment = "production"
  }
}
```

## Terragrunt Kullanımı

```hcl
# terragrunt.hcl
terraform {
  source = "git::https://github.com/your-org/terraform-huawei-ecs.git?ref=v1.0.0"
}

inputs = {
  name              = "pritunl-vpn"
  image_id          = "your-ubuntu-image-id"
  flavor_id         = "s6.small.1"
  security_group_ids = dependency.security_group.outputs.security_group_id
  availability_zone = "tr-west-1a"
  key_pair_name     = "my-keypair"

  network_ids = [
    {
      uuid = dependency.vpc.outputs.public_subnets[0]
    }
  ]

  create_eip         = true
  eip_bandwidth_size = 10

  user_data = file("${get_terragrunt_dir()}/user-data.sh")

  tags = {
    Application = "Pritunl"
    Environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| create | Whether to create ECS instance | bool | true | no |
| name | Name of the ECS instance | string | - | yes |
| image_id | ID of the image | string | - | yes |
| flavor_id | Flavor ID (instance type) | string | - | yes |
| security_group_ids | List of security group IDs | list(string) | [] | no |
| availability_zone | Availability zone | string | null | no |
| key_pair_name | Name of the key pair | string | null | no |
| system_disk_type | System disk type | string | "SSD" | no |
| system_disk_size | System disk size in GB | number | 40 | no |
| network_ids | List of network configurations | list(object) | [] | no |
| data_disks | List of data disks | list(object) | [] | no |
| user_data | User data script | string | null | no |
| create_eip | Whether to create an EIP | bool | false | no |
| eip_bandwidth_size | Bandwidth size in Mbps | number | 10 | no |
| tags | Tags to apply to resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Instance ID |
| name | Instance name |
| status | Instance status |
| private_ip | Private IP address |
| public_ip | Public IP address (if EIP created) |
| eip_address | EIP address |
| eip_id | EIP ID |

## Requirements

- Terraform >= 1.0
- Huawei Cloud Provider >= 1.47.0

## Yaygın Flavor'lar (Instance Types)

| Flavor | vCPU | RAM | Açıklama |
|--------|------|-----|----------|
| s6.small.1 | 1 | 1 GB | Küçük workload'lar |
| s6.medium.2 | 1 | 2 GB | Hafif uygulamalar |
| s6.large.2 | 2 | 4 GB | Orta seviye uygulamalar |
| s6.xlarge.2 | 4 | 8 GB | Büyük uygulamalar |
| s6.2xlarge.2 | 8 | 16 GB | Yoğun workload'lar |

## Disk Tipleri

- **SSD**: Yüksek performans SSD
- **GPSSD**: Genel amaçlı SSD
- **SAS**: Yüksek I/O SAS
- **SATA**: Kapasitif disk (ucuz)

## License

MIT

