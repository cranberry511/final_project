###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-e"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "gitlab"
  description = "VPC network"
}

variable "vpc_public_subnet_name" {
  type        = string
  default     = "public"
  description = "VPC public subnet name"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "sa_terraform_name" {
  type        = string
  default     = "terraform-sa"
}

variable "bucket_name" {
  type        = string
  default     = "mybucket-slkdm4895h"
}

variable "resource_preset_id" {
  type        = string
  default     = "s2.micro"
}

variable "disk_size" {
  type        = number
  default     = 30
}

variable "vm_cpu" {
  type        = number
  default     = 2
}

variable "vm_ram" {
  type        = number
  default     = 4
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "boot_disk_size" {
  type        = number
  default     = 10
}

variable "vm_nat" {
  type        = bool
  default     = true
}

variable "admin_login" {
  type        = string
}

variable "admin_email" {
  type        = string
}

variable "gitlab_domain" {
  type        = string
  default     = "gitlabslkdm4895h.gitlab.yandexcloud.net"
}

