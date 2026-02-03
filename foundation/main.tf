terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.42"
    }
  }
  required_version = ">= 1.0"
}

# Variables obligatoires du sujet
variable "binome_names" {
  description = "Noms des membres d equipe"
  type        = string
  default     = "chaieb-farikou-diomande"
}

variable "zone" {
  description = "Zone Scaleway (fr-par-1 ou fr-par-2)"
  type        = string
  default     = "fr-par-1"
}

variable "region" {
  description = "Région Scaleway (fr-par)"
  type        = string
  default     = "fr-par"
}

# Locals pour simplifier les noms dev/prod
locals {
  environments = ["dev", "prod"]
  domain_name = {
    dev  = "calculatrice-dev-${var.binome_names}"
    prod = "calculatrice-${var.binome_names}"
  }
  lb_name = {
    dev  = "lb-dev-${var.binome_names}"
    prod = "lb-prod-${var.binome_names}"
  }
}

# 1. Container Registry (unique)
resource "scaleway_registry_namespace" "main" {
  name        = "registry-${var.binome_names}"
  description = "Registry pour le projet calculatrice"
  is_public   = false
  region      = var.region
}

# 2. VPC Private Network (optionnelle mais utile)
resource "scaleway_vpc_private_network" "main" {
  name   = "vpc-${var.binome_names}"
  region = var.region
}

# 3. Kubernetes Cluster (unique)
resource "scaleway_k8s_cluster" "main" {
  name                        = "k8s-${var.binome_names}"
  version                     = "1.32"
  cni                         = "cilium"
  private_network_id          = scaleway_vpc_private_network.main.id
  delete_additional_resources = true
  region                      = var.region

  auto_upgrade {
    enable                       = true
    maintenance_window_start_hour = 3
    maintenance_window_day       = "monday"
  }
}

# 4. Node Pool (unique)
resource "scaleway_k8s_pool" "main" {
  cluster_id  = scaleway_k8s_cluster.main.id
  name        = "pool-${var.binome_names}"
  node_type   = "DEV1-M"
  size        = 2
  min_size    = 1
  max_size    = 3
  autoscaling = true
  autohealing = true
  zone        = var.zone
  region      = var.region
}

# 5. RDB PostgreSQL Instance (unique)
resource "scaleway_rdb_instance" "main" {
  name           = "db-${var.binome_names}"
  node_type      = "DB-DEV-S"
  engine         = "PostgreSQL-15"
  is_ha_cluster  = false
  disable_backup = true
  user_name      = "admin"
  password       = "SecurePassword2026!"  # À changer plus tard
  region         = var.region

  private_network {
    pn_id        = scaleway_vpc_private_network.main.id
    enable_ipam  = true
  }
}

# 6. Deux bases dans la même instance
resource "scaleway_rdb_database" "development" {
  instance_id = scaleway_rdb_instance.main.id
  name        = "development"
}

resource "scaleway_rdb_database" "production" {
  instance_id = scaleway_rdb_instance.main.id
  name        = "production"
}

# 7. IPs publiques + LoadBalancers (un par environnement)
resource "scaleway_lb_ip" "main" {
  for_each = toset(local.environments)
  zone     = var.zone
}

resource "scaleway_lb" "main" {
  for_each = toset(local.environments)
  name     = local.lb_name[each.key]
  type     = "LB-S"
  zone     = var.zone
  ip_ids   = [scaleway_lb_ip.main[each.key].id]
}

# 8. DNS Records (pointent vers les bonnes IPs)
resource "scaleway_domain_record" "main" {
  for_each = toset(local.environments)

  dns_zone = "polytech-dijon.kiowy.net"
  name     = local.domain_name[each.key]
  type     = "A"
  data     = scaleway_lb_ip.main[each.key].ip_address
  ttl      = 300
}

# Outputs à mettre dans ton README.md
output "registry_endpoint" {
  description = "Endpoint du registry"
  value       = scaleway_registry_namespace.main.endpoint
}

output "kubeconfig" {
  description = "Kubeconfig du cluster"
  value       = scaleway_k8s_cluster.main.kubeconfig[0].config_file
  sensitive   = true
}

output "db_endpoint" {
  description = "Endpoint de la base PostgreSQL"
  value       = "${scaleway_rdb_instance.main.private_network.0.ip}:${scaleway_rdb_instance.main.private_network.0.port}"
}