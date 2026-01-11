Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_instance.td_vm will be created
  + resource "google_compute_instance" "td_vm" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + creation_timestamp   = (known after apply)
      + current_status       = (known after apply)
      + deletion_protection  = false
      + effective_labels     = {
          + "goog-terraform-provisioned" = "true"
        }
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "n2-standard-2"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "td-vm"
      + project              = "Projet_TD2"
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + terraform_labels     = {
          + "goog-terraform-provisioned" = "true"
        }
      + zone                 = "europe-west9-a"

      + boot_disk {
          + auto_delete                = true
          + device_name                = (known after apply)
          + disk_encryption_key_sha256 = (known after apply)
          + guest_os_features          = (known after apply)
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)

          + initialize_params {
              + architecture           = (known after apply)
              + image                  = "debian-cloud/debian-12"
              + labels                 = (known after apply)
              + provisioned_iops       = (known after apply)
              + provisioned_throughput = (known after apply)
              + resource_policies      = (known after apply)
              + size                   = (known after apply)
              + snapshot               = (known after apply)
              + type                   = (known after apply)
            }
        }

      + confidential_instance_config (known after apply)

      + guest_accelerator (known after apply)

      + network_interface {
          + internal_ipv6_prefix_length = (known after apply)
          + ipv6_access_type            = (known after apply)
          + ipv6_address                = (known after apply)
          + name                        = (known after apply)
          + network                     = (known after apply)
          + network_attachment          = (known after apply)
          + network_ip                  = (known after apply)
          + stack_type                  = (known after apply)
          + subnetwork                  = (known after apply)
          + subnetwork_project          = (known after apply)

          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
        }

      + reservation_affinity (known after apply)

      + scheduling (known after apply)
    }

  # google_compute_network.td_vpc will be created
  + resource "google_compute_network" "td_vpc" {
      + auto_create_subnetworks                   = true
      + bgp_always_compare_med                    = (known after apply)
      + bgp_best_path_selection_mode              = (known after apply)
      + bgp_inter_region_cost                     = (known after apply)
      + delete_default_routes_on_create           = false
      + gateway_ipv4                              = (known after apply)
      + id                                        = (known after apply)
      + internal_ipv6_range                       = (known after apply)
      + mtu                                       = (known after apply)
      + name                                      = "td-vpc"
      + network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
      + network_id                                = (known after apply)
      + numeric_id                                = (known after apply)
      + project                                   = "Projet_TD2"
      + routing_mode                              = (known after apply)
      + self_link                                 = (known after apply)
    }

  # google_dns_managed_zone.kiowy_zone will be created
  + resource "google_dns_managed_zone" "kiowy_zone" {
      + creation_time    = (known after apply)
      + description      = "Managed by Terraform"
      + dns_name         = "kiowy.com."
      + effective_labels = {
          + "goog-terraform-provisioned" = "true"
        }
      + force_destroy    = false
      + id               = (known after apply)
      + managed_zone_id  = (known after apply)
      + name             = "kiowy-zone"
      + name_servers     = (known after apply)
      + project          = "Projet_TD2"
      + terraform_labels = {
          + "goog-terraform-provisioned" = "true"
        }
      + visibility       = "public"

      + cloud_logging_config (known after apply)

      + dnssec_config (known after apply)
    }

  # google_dns_record_set.td_dns_record will be created
  + resource "google_dns_record_set" "td_dns_record" {
      + id           = (known after apply)
      + managed_zone = "kiowy-zone"
      + name         = "www.kiowy.com."
      + project      = "Projet_TD2"
      + rrdatas      = (known after apply)
      + ttl          = 300
      + type         = "A"
    }

  # google_sql_database_instance.td_db will be created
  + resource "google_sql_database_instance" "td_db" {
      + available_maintenance_versions = (known after apply)
      + connection_name                = (known after apply)
      + database_version               = "POSTGRES_16"
      + deletion_protection            = true
      + dns_name                       = (known after apply)
      + dns_names                      = (known after apply)
      + encryption_key_name            = (known after apply)
      + first_ip_address               = (known after apply)
      + id                             = (known after apply)
      + instance_type                  = (known after apply)
      + ip_address                     = (known after apply)
      + maintenance_version            = (known after apply)
      + master_instance_name           = (known after apply)
      + name                           = "td-db"
      + node_count                     = (known after apply)
      + private_ip_address             = (known after apply)
      + project                        = "Projet_TD2"
      + psc_service_attachment_link    = (known after apply)
      + public_ip_address              = (known after apply)
      + region                         = "europe-west9"
      + replica_names                  = (known after apply)
      + self_link                      = (known after apply)
      + server_ca_cert                 = (sensitive value)
      + service_account_email_address  = (known after apply)

      + replica_configuration (known after apply)

      + replication_cluster (known after apply)

      + settings {
          + activation_policy           = "ALWAYS"
          + availability_type           = "ZONAL"
          + connector_enforcement       = (known after apply)
          + disk_autoresize             = true
          + disk_autoresize_limit       = 0
          + disk_size                   = (known after apply)
          + disk_type                   = (known after apply)
          + edition                     = (known after apply)
          + effective_availability_type = (known after apply)
          + pricing_plan                = "PER_USE"
          + tier                        = "db-f1-micro"
          + user_labels                 = (known after apply)
          + version                     = (known after apply)

          + backup_configuration (known after apply)

          + connection_pool_config (known after apply)

          + data_cache_config (known after apply)

          + insights_config (known after apply)

          + ip_configuration (known after apply)

          + location_preference (known after apply)

          + read_pool_auto_scale_config (known after apply)
        }
    }

Plan: 5 to add, 0 to change, 0 to destroy.