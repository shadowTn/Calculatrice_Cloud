# FICHIER PRINCIPAL DE CONFIGURATION TERRAFORM
# Projet : Calculatrice Cloud Native
# Binôme : Moussa & Amen
# Région : Paris (fr-par)

# Configure le fournisseur (provider) Scaleway.
# C'est ici qu'on définit la version du provider et qu'on s'assure
# que Terraform saura comment interagir avec l'API de Scaleway.
terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.0"
    }
  }
  required_version = ">= 1.0"
}

# Configuration du provider avec la région et le projet.
# La région est définie via une variable pour plus de flexibilité.
provider "scaleway" {
  zone       = var.zone
  project_id = var.project_id
}

# RESSOURCES DE L'INFRASTRUCTURE
# 1. REGISTRE DE CONTENEURS (Container Registry)
# Ce registre stockera les images Docker de nos microservices :
# - Frontend (interface utilisateur)
# - Backend (API REST)
# - Consumer (traitement des calculs)
# Il est configuré en privé pour sécuriser notre code.
resource "scaleway_registry_namespace" "main" {
  name        = "calculatrice-registry-moussa-amen"
  description = "Registre de conteneurs pour la calculatrice Cloud Native - Binôme Moussa & Amen"
  is_public   = false
  region      = var.region
}

# 2. CLUSTER KUBERNETES (K8s)
# C'est le cœur de notre application. Il orchestrera nos conteneurs.
# On utilise un cluster Kapsule, qui est la solution managée de Scaleway.
# Configuration :
# - Version : 1.29.x (avec auto-upgrade activé)
# - CNI : Cilium (pour la gestion du réseau)
# - Auto-scaling : Activé pour adapter les ressources à la charge
resource "scaleway_k8s_cluster" "main" {
  name                        = "calculatrice-cluster-moussa-amen"
  region                      = var.region
  version                     = "1.29.0"
  cni                         = "cilium"
  delete_additional_resources = false

  # Configuration de l'auto-upgrade pour les mises à jour automatiques
  auto_upgrade {
    enable                        = false
    maintenance_window_day        = "monday"
    maintenance_window_start_hour = 2
  }

  # Configuration de l'autoscaler pour adapter le nombre de nœuds
  autoscaler_config {
    disable_scale_down         = false
    scale_down_delay_after_add = "10m"
    estimator                  = "binpacking"
  }
}

# 3. POOL DE NOEUDS KUBERNETES
# Pool de nœuds par défaut pour le cluster.
# Configuration :
# - Type : DEV1-M (instances suffisantes pour ce projet)
# - Taille initiale : 3 nœuds
# - Auto-scaling : Entre 1 et 5 nœuds selon la charge
# - Auto-healing : Activé pour remplacer les nœuds défaillants
resource "scaleway_k8s_pool" "default" {
  cluster_id  = scaleway_k8s_cluster.main.id
  name        = "default-pool-moussa-amen"
  node_type   = "DEV1-M"
  size        = 3
  min_size    = 1
  max_size    = 5
  autoscaling = true
  autohealing = true
  tags        = ["calculatrice", "pool-default", "moussa-amen"]
}

# 4. RÉSEAU PRIVÉ VPC
# Réseau privé pour la communication sécurisée entre nos ressources.
# Permet à Kubernetes, Redis et autres services de communiquer sans passer par Internet.
resource "scaleway_vpc_private_network" "main" {
  name = "vpc-calculatrice-moussa-amen"
  tags = ["calculatrice", "moussa-amen"]
}

# 5. BASES DE DONNÉES REDIS
# Redis est utilisé pour stocker les résultats des calculs de manière persistante.
# On crée deux instances : une pour le développement et une pour la production.
# Chacune est connectée au réseau privé VPC pour la sécurité.

# Redis pour l'environnement de DÉVELOPPEMENT
resource "scaleway_redis_cluster" "db_dev" {
  name         = "redis-db-dev-moussa-amen"
  version      = "7.2"
  zone         = var.zone
  node_type    = "REDIS-DEV-S"
  cluster_size = 1
  tls_enabled  = true
  user_name    = "dev_user"
  password     = var.redis_dev_password

  # Configuration du réseau privé pour la communication sécurisée
  private_network {
    id = scaleway_vpc_private_network.main.id
  }

  tags = ["calculatrice", "dev", "moussa-amen"]
}

# Redis pour l'environnement de PRODUCTION
resource "scaleway_redis_cluster" "db_prod" {
  name         = "redis-db-prod-moussa-amen"
  version      = "7.2"
  zone         = var.zone
  node_type    = "REDIS-DEV-S"
  cluster_size = 1
  tls_enabled  = true
  user_name    = "prod_user"
  password     = var.redis_prod_password

  # Configuration du réseau privé pour la communication sécurisée
  private_network {
    id = scaleway_vpc_private_network.main.id
  }

  tags = ["calculatrice", "prod", "moussa-amen"]
}

# 6. LOAD BALANCERS
# Les Load Balancers exposent nos services sur Internet et répartissent le trafic.
# On en crée un pour l'environnement de développement et un pour la production.
# Chacun a sa propre adresse IP publique et son propre enregistrement DNS.

# Load Balancer pour l'environnement de DÉVELOPPEMENT
resource "scaleway_lb" "lb_dev" {
  name        = "lb-dev-moussa-amen"
  description = "Load Balancer pour l'environnement de développement - Binôme Moussa & Amen"
  type        = "LB-S"
  zone        = var.zone
  tags        = ["calculatrice", "dev", "moussa-amen"]
}

# Load Balancer pour l'environnement de PRODUCTION
resource "scaleway_lb" "lb_prod" {
  name        = "lb-prod-moussa-amen"
  description = "Load Balancer pour l'environnement de production - Binôme Moussa & Amen"
  type        = "LB-S"
  zone        = var.zone
  tags        = ["calculatrice", "prod", "moussa-amen"]
}

# 7. ENREGISTREMENTS DNS

# On crée les entrées DNS pour que les noms de domaine pointent vers nos Load Balancers.
# Cela permet d'accéder à l'application via une URL conviviale.
# Format : calculatrice-[dev-]moussa-amen.polytech-dijon.kiowy.net

# Enregistrement DNS pour l'environnement de DÉVELOPPEMENT
resource "scaleway_domain_record" "dns_dev" {
  dns_zone = var.dns_zone
  name     = "calculatrice-dev-moussa-amen"
  type     = "A"
  data     = scaleway_lb.lb_dev.ip_address
  ttl      = 3600
}

# Enregistrement DNS pour l'environnement de PRODUCTION
resource "scaleway_domain_record" "dns_prod" {
  dns_zone = var.dns_zone
  name     = "calculatrice-moussa-amen"
  type     = "A"
  data     = scaleway_lb.lb_prod.ip_address
  ttl      = 3600
}

