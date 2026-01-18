# Foundation - Infrastructure Terraform

## Description
Configuration Terraform pour provisionner l'infrastructure sur Scaleway (registre, cluster K8s, Redis, Load Balancers, DNS).

## Architecture
- Cluster Kubernetes (1.29.x) avec 3 nœuds
- Registre de conteneurs privé
- 2 bases de données Redis (dev et prod)
- 2 Load Balancers (dev et prod)
- 2 enregistrements DNS
- Réseau privé VPC

## Fichiers
- `main.tf` : Ressources Terraform
- `variables.tf` : Variables
- `outputs.tf` : Sorties
- `terraform.tfvars` : Valeurs (à personnaliser)

## Configuration
1. Remplacez l'ID Scaleway dans `terraform.tfvars`
2. Exécutez `terraform init`
3. Exécutez `terraform plan`
4. Exécutez `terraform apply`

## Ressources créées
- Cluster : `calculatrice-cluster-moussa-amen`
- Registre : `calculatrice-registry-moussa-amen`
- Redis DEV : `redis-db-dev-moussa-amen`
- Redis PROD : `redis-db-prod-moussa-amen`
- LB DEV : `lb-dev-moussa-amen`
- LB PROD : `lb-prod-moussa-amen`
- DNS DEV : `calculatrice-dev-moussa-amen.polytech-dijon.kiowy.net`
- DNS PROD : `calculatrice-moussa-amen.polytech-dijon.kiowy.net`
