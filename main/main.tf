resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public1" {
  name           = var.vpc_public_subnet_name1
  zone           = var.zone1
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr1
}

resource "yandex_vpc_subnet" "public2" {
  name           = var.vpc_public_subnet_name2
  zone           = var.zone2
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr2
}

resource "yandex_vpc_subnet" "public3" {
  name           = var.vpc_public_subnet_name3
  zone           = var.zone3
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr3
}

resource "yandex_container_registry" "my-reg" {
  name = "my-registry"
}

output "container_registry_url" {
  value = "cr.yandex/${yandex_container_registry.my-reg.id}"
}


data "yandex_iam_service_account" "terraform-sa" {
  name = "terraform-sa"
}

resource "yandex_kubernetes_cluster" "my_k8s_regional_cluster" {
  name        = "mycluster"

  network_id = yandex_vpc_network.develop.id

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.public1.zone
        subnet_id = yandex_vpc_subnet.public1.id
      }

      location {
        zone      = yandex_vpc_subnet.public2.zone
        subnet_id = yandex_vpc_subnet.public2.id
      }

      location {
        zone      = yandex_vpc_subnet.public3.zone
        subnet_id = yandex_vpc_subnet.public3.id
      }
    }

    version   = var.k8s_version
    public_ip = var.public_ip_k8s
  }

  service_account_id      = data.yandex_iam_service_account.terraform-sa.id
  node_service_account_id = data.yandex_iam_service_account.terraform-sa.id
}

resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id = yandex_kubernetes_cluster.my_k8s_regional_cluster.id
  name       = "mynodegroup"
  version     = var.k8s_version

  instance_template {
    platform_id = var.platform_id
    resources {
      cores         = var.vm_cpu
      core_fraction = var.vm_core_fraction
      memory        = var.vm_ram
    }
    network_interface {
      nat = var.vm_nat
      subnet_ids  = [yandex_vpc_subnet.public1.id]
    }
    scheduling_policy {
      preemptible = var.vm_preemptible
    }
  }

  allocation_policy {
    location {
      zone = var.zone1
    }
  }
  scale_policy {
    fixed_scale {
      size = var.k8s_worker_nodes_count
    }
  }
}

resource "null_resource" "create_kubeconfig_file" {
  depends_on = [yandex_kubernetes_cluster.my_k8s_regional_cluster]
  provisioner "local-exec" {
    command = "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.my_k8s_regional_cluster.id} --external --kubeconfig $HOME/.kube/myconfig --force"
  }
}