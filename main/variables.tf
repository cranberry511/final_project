###cloud vars
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

variable "zone1" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone2" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone3" {
  type        = string
  default     = "ru-central1-e"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network"
}

variable "vpc_public_subnet_name1" {
  type        = string
  default     = "public1"
  description = "VPC public subnet name"
}

variable "vpc_public_subnet_name2" {
  type        = string
  default     = "public2"
  description = "VPC public subnet name"
}

variable "vpc_public_subnet_name3" {
  type        = string
  default     = "public3"
  description = "VPC public subnet name"
}

variable "public_cidr1" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr2" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr3" {
  type        = list(string)
  default     = ["192.168.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_cpu" {
  type        = number
  default     = 2
}

variable "public_ip_k8s" {
  type        = bool
  default     = true
}

variable "vm_ram" {
  type        = number
  default     = 4
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_preemptible" {
  type        = bool
  default     = true
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "k8s_version" {
  type        = string
  default     = "1.33"
}

variable "k8s_worker_nodes_count" {
  type        = number
  default     = 3
}

variable "vm_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_nat" {
  type        = bool
  default     = true
}