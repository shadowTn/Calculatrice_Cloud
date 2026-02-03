Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # scaleway_domain_record.main["dev"] will be created
  + resource "scaleway_domain_record" "main" {
      + data       = (known after apply)
      + dns_zone   = "polytech-dijon.kiowy.net"
      + fqdn       = (known after apply)
      + id         = (known after apply)
      + name       = "calculatrice-dev-chaieb-farikou-diomande"
      + priority   = (known after apply)
      + project_id = (known after apply)
      + root_zone  = (known after apply)
      + ttl        = 300
      + type       = "A"
    }

  # scaleway_domain_record.main["prod"] will be created
  + resource "scaleway_domain_record" "main" {
      + data       = (known after apply)
      + dns_zone   = "polytech-dijon.kiowy.net"
      + fqdn       = (known after apply)
      + id         = (known after apply)
      + name       = "calculatrice-chaieb-farikou-diomande"
      + priority   = (known after apply)
      + project_id = (known after apply)
      + root_zone  = (known after apply)
      + ttl        = 300
      + type       = "A"
    }

  # scaleway_k8s_cluster.main will be created
  + resource "scaleway_k8s_cluster" "main" {
      + apiserver_url               = (known after apply)
      + cni                         = "cilium"
      + created_at                  = (known after apply)
      + delete_additional_resources = true
      + id                          = (known after apply)
      + kubeconfig                  = (sensitive value)
      + name                        = "k8s-chaieb-farikou-diomande"
      + organization_id             = (known after apply)
      + pod_cidr                    = (known after apply)
      + private_network_id          = (known after apply)
      + project_id                  = (known after apply)
      + service_cidr                = (known after apply)
      + service_dns_ip              = (known after apply)
      + status                      = (known after apply)
      + type                        = (known after apply)
      + updated_at                  = (known after apply)
      + upgrade_available           = (known after apply)
      + version                     = "1.32"
      + wildcard_dns                = (known after apply)

      + auto_upgrade {
          + enable                        = true
          + maintenance_window_day        = "monday"
          + maintenance_window_start_hour = 3
        }

      + autoscaler_config (known after apply)

      + open_id_connect_config (known after apply)
    }

  # scaleway_k8s_pool.main will be created
  + resource "scaleway_k8s_pool" "main" {
      + autohealing            = true
      + autoscaling            = true
      + cluster_id             = (known after apply)
      + container_runtime      = "containerd"
      + created_at             = (known after apply)
      + current_size           = (known after apply)
      + id                     = (known after apply)
      + max_size               = 3
      + min_size               = 1
      + name                   = "pool-chaieb-farikou-diomande"
      + node_type              = "DEV1-M"
      + nodes                  = (known after apply)
      + public_ip_disabled     = false
      + root_volume_size_in_gb = (known after apply)
      + root_volume_type       = (known after apply)
      + security_group_id      = (known after apply)
      + size                   = 2
      + status                 = (known after apply)
      + updated_at             = (known after apply)
      + version                = (known after apply)
      + wait_for_pool_ready    = true

      + upgrade_policy (known after apply)
    }

  # scaleway_lb.main["dev"] will be created
  + resource "scaleway_lb" "main" {
      + external_private_networks = false
      + id                        = (known after apply)
      + ip_address                = (known after apply)
      + ip_id                     = (known after apply)
      + ip_ids                    = [
          + (known after apply),
        ]
      + ipv6_address              = (known after apply)
      + name                      = "lb-dev-chaieb-farikou-diomande"
      + organization_id           = (known after apply)
      + private_ips               = (known after apply)
      + project_id                = (known after apply)
      + region                    = (known after apply)
      + ssl_compatibility_level   = "ssl_compatibility_level_intermediate"
      + type                      = "LB-S"

      + private_network (known after apply)
    }

  # scaleway_lb.main["prod"] will be created
  + resource "scaleway_lb" "main" {
      + external_private_networks = false
      + id                        = (known after apply)
      + ip_address                = (known after apply)
      + ip_id                     = (known after apply)
      + ip_ids                    = [
          + (known after apply),
        ]
      + ipv6_address              = (known after apply)
      + name                      = "lb-prod-chaieb-farikou-diomande"
      + organization_id           = (known after apply)
      + private_ips               = (known after apply)
      + project_id                = (known after apply)
      + region                    = (known after apply)
      + ssl_compatibility_level   = "ssl_compatibility_level_intermediate"
      + type                      = "LB-S"

      + private_network (known after apply)
    }

  # scaleway_lb_ip.main["dev"] will be created
  + resource "scaleway_lb_ip" "main" {
      + id              = (known after apply)
      + ip_address      = (known after apply)
      + is_ipv6         = false
      + lb_id           = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + region          = (known after apply)
      + reverse         = (known after apply)
    }

  # scaleway_lb_ip.main["prod"] will be created
  + resource "scaleway_lb_ip" "main" {
      + id              = (known after apply)
      + ip_address      = (known after apply)
      + is_ipv6         = false
      + lb_id           = (known after apply)
      + organization_id = (known after apply)
      + project_id      = (known after apply)
      + region          = (known after apply)
      + reverse         = (known after apply)
    }

  # scaleway_rdb_database.development will be created
  + resource "scaleway_rdb_database" "development" {
      + id          = (known after apply)
      + instance_id = (known after apply)
      + managed     = (known after apply)
      + name        = "development"
      + owner       = (known after apply)
      + size        = (known after apply)
    }

  # scaleway_rdb_database.production will be created
  + resource "scaleway_rdb_database" "production" {
      + id          = (known after apply)
      + instance_id = (known after apply)
      + managed     = (known after apply)
      + name        = "production"
      + owner       = (known after apply)
      + size        = (known after apply)
    }

  # scaleway_rdb_instance.main will be created
  + resource "scaleway_rdb_instance" "main" {
      + backup_same_region        = (known after apply)
      + backup_schedule_frequency = (known after apply)
      + backup_schedule_retention = (known after apply)
      + certificate               = (known after apply)
      + disable_backup            = true
      + endpoint_ip               = (known after apply)
      + endpoint_port             = (known after apply)
      + engine                    = "PostgreSQL-15"
      + id                        = (known after apply)
      + is_ha_cluster             = false
      + name                      = "db-chaieb-farikou-diomande"
      + node_type                 = "DB-DEV-S"
      + organization_id           = (known after apply)
      + password                  = (sensitive value)
      + project_id                = (known after apply)
      + read_replicas             = (known after apply)
      + settings                  = (known after apply)
      + upgradable_versions       = (known after apply)
      + user_name                 = "admin"
      + volume_size_in_gb         = (known after apply)
      + volume_type               = "lssd"

      + logs_policy (known after apply)

      + private_ip (known after apply)

      + private_network {
          + enable_ipam = true
          + endpoint_id = (known after apply)
          + hostname    = (known after apply)
          + ip          = (known after apply)
          + ip_net      = (known after apply)
          + name        = (known after apply)
          + pn_id       = (known after apply)
          + port        = (known after apply)
        }
    }

  # scaleway_registry_namespace.main will be created
  + resource "scaleway_registry_namespace" "main" {
      + description     = "Registry pour le projet calculatrice"
      + endpoint        = (known after apply)
      + id              = (known after apply)
      + is_public       = false
      + name            = "registry-chaieb-farikou-diomande"
      + organization_id = (known after apply)
      + project_id      = (known after apply)
    }

  # scaleway_vpc_private_network.main will be created
  + resource "scaleway_vpc_private_network" "main" {
      + created_at                       = (known after apply)
      + enable_default_route_propagation = (known after apply)
      + id                               = (known after apply)
      + is_regional                      = (known after apply)
      + name                             = "vpc-chaieb-farikou-diomande"
      + organization_id                  = (known after apply)
      + project_id                       = (known after apply)
      + updated_at                       = (known after apply)
      + vpc_id                           = (known after apply)
      + zone                             = (known after apply)

      + ipv4_subnet (known after apply)

      + ipv6_subnets (known after apply)
    }

Plan: 13 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + db_endpoint       = (known after apply)
  + kubeconfig        = (sensitive value)
  + registry_endpoint = (known after apply)