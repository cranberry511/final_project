terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "= 0.201"
    }
    null = {
      source = "hashicorp/null"
      version = "= 3.3.0"
    }
  }
  required_version = "=1.14.0"

  backend "s3" {
    bucket  = "mybucket-slkdm4895h"
    key     = "terraform.tfstate"
    region  = "ru-central1"

    use_lockfile = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  service_account_key_file = file("~/.authorized_key_terraform.json")
}