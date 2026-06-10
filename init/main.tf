// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa-for-terraform" {
  name        = var.sa_terraform_name
}

// Выдаем права на редактирование
resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id   = var.folder_id
  role        = "editor"
  member      = "serviceAccount:${yandex_iam_service_account.sa-for-terraform.id}"
}

// Создание файла-ключа для SA
resource "yandex_iam_service_account_key" "sa-auth-key" {
  service_account_id = yandex_iam_service_account.sa-for-terraform.id
}

resource "local_file" "sa_key_file" {
  content = jsonencode({
    "id" : yandex_iam_service_account_key.sa-auth-key.id,
    "service_account_id" : yandex_iam_service_account_key.sa-auth-key.service_account_id,
    "created_at" : yandex_iam_service_account_key.sa-auth-key.created_at,
    "key_algorithm" : yandex_iam_service_account_key.sa-auth-key.key_algorithm,
    "public_key" : yandex_iam_service_account_key.sa-auth-key.public_key,
    "private_key" : yandex_iam_service_account_key.sa-auth-key.private_key
  })
  filename = pathexpand("~/.authorized_key_terraform.json")
}

resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa-for-terraform.id
}

// Автоматически создаем файл ~/.aws/credentials
resource "local_file" "aws_credentials" {
  filename = pathexpand("~/.aws/credentials")
  content  = <<-EOT
[default]
aws_access_key_id = ${yandex_iam_service_account_static_access_key.sa_static_key.access_key}
aws_secret_access_key = ${yandex_iam_service_account_static_access_key.sa_static_key.secret_key}
EOT
}

// Автоматически создаем файл ~/.aws/config
resource "local_file" "aws_config" {
  filename = pathexpand("~/.aws/config")
  content  = <<-EOT
[default]
region = ru-central1
endpoint_url = https://storage.yandexcloud.net
EOT
}

resource "yandex_storage_bucket" "my_bucket" {
  bucket     = var.bucket_name
  folder_id  = var.folder_id
  force_destroy = true
}


resource "yandex_vpc_network" "gitlab" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.gitlab.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_gitlab_instance" "my_gitlab" {
  name               = "my-gitlab-instance"
  subnet_id          = yandex_vpc_subnet.public.id
  resource_preset_id = var.resource_preset_id
  approval_rules_id = "NONE"
  disk_size                 = var.disk_size
  admin_login               = var.admin_login
  admin_email               = var.admin_email
  domain                    = var.gitlab_domain
  backup_retain_period_days = 1
}

resource "yandex_compute_instance" "gitlab-runner" {
  name        = "gitlab-runner"
  zone        = var.default_zone

  resources {
    cores  = var.vm_cpu
    memory = var.vm_ram
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id =var.vm_image_id
      size     = var.boot_disk_size
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = var.vm_nat
  }

  metadata = {
      user-data = data.template_file.cloudinit.rendered
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/id_ed25519.pub")
  }
}
