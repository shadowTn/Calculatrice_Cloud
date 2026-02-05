variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "bucket_name" {
  description = "Nom du bucket AWS"
  type        = string
}
