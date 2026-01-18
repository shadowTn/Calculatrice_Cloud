 # scaleway_domain_record.dns_dev will be created
  + resource "scaleway_domain_record" "dns_dev" {
      + data       = (known after apply)
      + dns_zone   = "polytech-dijon.kiowy.net"
      + fqdn       = (known after apply)
      + id         = (known after apply)
      + name       = "calculatrice-dev-moussa-amen"
      + priority   = (known after apply)
      + project_id = (known after apply)
      + root_zone  = (known after apply)
      + ttl        = 3600
      + type       = "A"
    }

  # scaleway_domain_record.dns_prod will be created
  + resource "scaleway_domain_record" "dns_prod" {
      + data       = (known after apply)
      + dns_zone   = "polytech-dijon.kiowy.net"
      + fqdn       = (known after apply)
      + id         = (known after apply)
      + name       = "calculatrice-moussa-amen"
      + priority   = (known after apply)
      + project_id = (known after apply)
      + root_zone  = (known after apply)
      + ttl        = 3600
      + type       = "A"
    }

  # scaleway_k8s_cluster.main will be created
  + resource "scaleway_k8s_cluster" "main" {
      + apiserver_url               = (known after apply)
      + cni                         = "cilium"
      + created_at                  = (known after apply)
      + delete_additional_resources = false
      + id                          = (known after apply)
      + kubeconfig                  = (sensitive value)
      + name                        = "calculatrice-cluster-moussa-amen"
      + organization_id             = (known after apply)
      + pod_cidr                    = (known after apply)
      + project_id                  = (known after apply)
      + service_cidr                = (known after apply)
      + service_dns_ip              = (known after apply)
      + status                      = (known after apply)
      + type                        = (known after apply)
      + updated_at                  = (known after apply)
      + upgrade_available           = (known after apply)
      + version                     = "1.29.0"
      + wildcard_dns                = (known after apply)

      + auto_upgrade {
          + enable                        = false
          + maintenance_window_day        = "monday"
          + maintenance_window_start_hour = 2
        }

      + autoscaler_config {
          + balance_similar_node_groups      = false
          + disable_scale_down               = false
          + estimator                        = "binpacking"
          + expander                         = "random"
          + expendable_pods_priority_cutoff  = -10
          + ignore_daemonsets_utilization    = false
          + max_graceful_termination_sec     = 600
          + scale_down_delay_after_add       = "10m"
          + scale_down_unneeded_time         = "10m"
          + scale_down_utilization_threshold = 0.5
        }

      + open_id_connect_config (known after apply)
    }

  # scaleway_k8s_pool.default will be created
  + resource "scaleway_k8s_pool" "default" {
      + autohealing            = true
      + autoscaling            = true
      + cluster_id             = (known after apply)
      + container_runtime      = "containerd"
      + created_at             = (known after apply)
      + current_size           = (known after apply)
      + id                     = (known after apply)
      + max_size               = 5
      + min_size               = 1
      + name                   = "default-pool-moussa-amen"
      + node_type              = "DEV1-M"
      + nodes                  = (known after apply)
      + public_ip_disabled     = false
      + root_volume_size_in_gb = (known after apply)
      + root_volume_type       = (known after apply)
      + security_group_id      = (known after apply)
      + size                   = 3
      + status                 = (known after apply)
      + tags                   = [
          + "calculatrice",
          + "pool-default",
          + "moussa-amen",
        ]
      + updated_at             = (known after apply)
      + version                = (known after apply)
      + wait_for_pool_ready    = true

      + upgrade_policy (known after apply)
    }

  # scaleway_lb.lb_dev will be created
  + resource "scaleway_lb" "lb_dev" {
      + description               = "Load Balancer pour l'environnement de développement - Binôme Moussa & Amen"
      + external_private_networks = false
      + id                        = (known after apply)
      + ip_address                = (known after apply)
      + ip_id                     = (known after apply)
      + ip_ids                    = (known after apply)
      + ipv6_address              = (known after apply)
      + name                      = "lb-dev-moussa-amen"
      + organization_id           = (known after apply)
      + private_ips               = (known after apply)
      + project_id                = (known after apply)
      + region                    = (known after apply)
      + ssl_compatibility_level   = "ssl_compatibility_level_intermediate"
      + tags                      = [
          + "calculatrice",
          + "dev",
          + "moussa-amen",
        ]
      + type                      = "LB-S"

      + private_network (known after apply)
    }

  # scaleway_lb.lb_prod will be created
  + resource "scaleway_lb" "lb_prod" {
      + description               = "Load Balancer pour l'environnement de production - Binôme Moussa & Amen"
      + external_private_networks = false
      + id                        = (known after apply)
      + ip_address                = (known after apply)
      + ip_id                     = (known after apply)
      + ip_ids                    = (known after apply)
      + ipv6_address              = (known after apply)
      + name                      = "lb-prod-moussa-amen"
      + organization_id           = (known after apply)
      + private_ips               = (known after apply)
      + project_id                = (known after apply)
      + region                    = (known after apply)
      + ssl_compatibility_level   = "ssl_compatibility_level_intermediate"
      + tags                      = [
          + "calculatrice",
          + "prod",
          + "moussa-amen",
        ]
      + type                      = "LB-S"

      + private_network (known after apply)
    }

  # scaleway_redis_cluster.db_dev will be created
  + resource "scaleway_redis_cluster" "db_dev" {
      + certificate  = (known after apply)
      + cluster_size = 1
      + created_at   = (known after apply)
      + id           = (known after apply)
      + name         = "redis-db-dev-moussa-amen"
      + node_type    = "REDIS-DEV-S"
      + password     = (sensitive value)
      + project_id   = (known after apply)
      + tags         = [
          + "calculatrice",
          + "dev",
          + "moussa-amen",
        ]
      + tls_enabled  = true
      + updated_at   = (known after apply)
      + user_name    = "dev_user"
      + version      = "7.2"

      + private_ips (known after apply)

      + private_network {
          + endpoint_id = (known after apply)
          + id          = (known after apply)
          + ips         = (known after apply)
          + port        = (known after apply)
          + service_ips = (known after apply)
          + zone        = (known after apply)
        }

      + public_network (known after apply)
    }

  # scaleway_redis_cluster.db_prod will be created
  + resource "scaleway_redis_cluster" "db_prod" {
      + certificate  = (known after apply)
      + cluster_size = 1
      + created_at   = (known after apply)
      + id           = (known after apply)
      + name         = "redis-db-prod-moussa-amen"
      + node_type    = "REDIS-DEV-S"
      + password     = (sensitive value)
      + project_id   = (known after apply)
      + tags         = [
          + "calculatrice",
          + "prod",
          + "moussa-amen",
        ]
      + tls_enabled  = true
      + updated_at   = (known after apply)
      + user_name    = "prod_user"
      + version      = "7.2"

      + private_ips (known after apply)

      + private_network {
          + endpoint_id = (known after apply)
          + id          = (known after apply)
          + ips         = (known after apply)
          + port        = (known after apply)
          + service_ips = (known after apply)
          + zone        = (known after apply)
        }

      + public_network (known after apply)
    }

  # scaleway_registry_namespace.main will be created
  + resource "scaleway_registry_namespace" "main" {
      + description     = "Registre de conteneurs pour la calculatrice Cloud Native - Binôme Moussa & Amen"
      + endpoint        = (known after apply)
      + id              = (known after apply)
      + is_public       = false
      + name            = "calculatrice-registry-moussa-amen"
      + organization_id = (known after apply)
      + project_id      = (known after apply)
    }

  # scaleway_vpc_private_network.main will be created
  + resource "scaleway_vpc_private_network" "main" {
      + created_at                       = (known after apply)
      + enable_default_route_propagation = (known after apply)
      + id                               = (known after apply)
      + is_regional                      = (known after apply)
      + name                             = "vpc-calculatrice-moussa-amen"
      + organization_id                  = (known after apply)
      + project_id                       = (known after apply)
      + tags                             = [
          + "calculatrice",
          + "moussa-amen",
        ]
      + updated_at                       = (known after apply)
      + vpc_id                           = (known after apply)
      + zone                             = (known after apply)

      + ipv4_subnet (known after apply)

      + ipv6_subnets (known after apply)
    }

Plan: 10 to add, 0 to change, 0 to destroy.
