#TD2 – Terraform AWS

 Objectif
Déployer un bucket S3 privé sur AWS à l’aide de Terraform.

Ce TD permet de comprendre :
- la structure d’un projet Terraform,
- la déclaration d’un provider AWS,
- l’utilisation des variables,
- la création d’une ressource S3,
- l’exécution de `terraform init` et `terraform plan  


terraform plan Resultat
var.bucket_name
  Nom du bucket AWS

  Enter a value: moussa-td2-aws-bucket

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.bucket_td2 will be created
  + resource "aws_s3_bucket" "bucket_td2" {
      + acl                         = "private"
      + bucket                      = "moussa-td2-aws-bucket"
      + region                      = "eu-west-3"
      + id                          = (known after apply)
      + arn                         = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + hosted_zone_id              = (known after apply)
      + tags_all                    = (known after apply)
      + website_endpoint            = (known after apply)
      + website_domain              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_name = "moussa-td2-aws-bucket"

Warning: acl is deprecated. Use the aws_s3_bucket_acl resource instead.
