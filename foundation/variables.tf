
# Projet : Calculatrice Cloud Native
# Binôme : Moussa & Amen
# Variable pour l'identifiant du binôme
# Cette variable est utilisée dans les noms de toutes les ressources créées.
variable "binome_id" {
  description = "Identifiant unique du binôme ( moussa-amen)"
  type        = string
  default     = "moussa-amen"
}

# Variable pour la région Scaleway
variable "region" {
  description = "Région Scaleway pour le déploiement ( fr-par pour Paris)"
  type        = string
  default     = "fr-par"
}

# Variable pour la zone Scaleway
# Certaines ressources comme les bases de données sont zonales.
# Valeur : fr-par-1 (Zone 1 de Paris)
variable "zone" {
  description = "Zone Scaleway pour le déploiement (ex: fr-par-1)"
  type        = string
  default     = "fr-par-1"
}

variable "project_id" {
  description = "ID du projet Scaleway (à remplacer par votre ID réel)"
  type        = string
  default     = "12345678-1234-1234-1234-123456789012"
}

# Variable pour la zone DNS
# Le nom de domaine principal où les enregistrements seront créés.
# Valeur : polytech-dijon.kiowy.net (domaine fourni par l'école)
variable "dns_zone" {
  description = "Zone DNS principale (ex: polytech-dijon.kiowy.net)"
  type        = string
  default     = "polytech-dijon.kiowy.net"
}

# Variable pour le mot de passe Redis de développement
# Utilisé pour sécuriser l'accès à la base de données Redis de développement.

# Recommandations de sécurité :
# - Minimum 16 caractères
# - Incluez des majuscules, minuscules, chiffres et caractères spéciaux
# - Exemple : "DevP@ss2026Secure!"
variable "redis_dev_password" {
  description = "Mot de passe pour la base de données Redis de développement"
  type        = string
  sensitive   = true
  default     = "DevPassword2026Secure!"
}

# Recommandations de sécurité :
# - Minimum 20 caractères
# - Incluez des majuscules, minuscules, chiffres et caractères spéciaux
# - Générez un mot de passe aléatoire sécurisé
# - Exemple : "ProdP@ss2026Secure#Ultra!"
variable "redis_prod_password" {
  description = "Mot de passe pour la base de données Redis de production"
  type        = string
  sensitive   = true
  default     = "ProdPassword2026Secure#Ultra!"
}