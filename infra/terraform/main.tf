terraform {
  required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Rede Bridge isolada para o laboratório
resource "docker_network" "bjsports_lab_net" {
  name   = "bjsports_lab_network"
  driver = "bridge"
}

# Volumes persistentes
resource "docker_volume" "postgres_data" {
  name = "bjsports_postgres_data"
}

resource "docker_volume" "redis_data" {
  name = "bjsports_redis_data"
}

# Imagens Docker
resource "docker_image" "postgres" {
  name         = "postgres:16-alpine"
  keep_locally = true
}

resource "docker_image" "redis" {
  name         = "redis:7-alpine"
  keep_locally = true
}

resource "docker_image" "adminer" {
  name         = "adminer:latest"
  keep_locally = true
}

# Container PostgreSQL 16
resource "docker_container" "postgres" {
  name  = "bjsports_postgres_lab"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=${var.postgres_db_name}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  ports {
    internal = 5432
    external = var.postgres_port
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  volumes {
    host_path      = "${abspath(path.module)}/scripts/init.sql"
    container_path = "/docker-entrypoint-initdb.d/init.sql"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.bjsports_lab_net.name
  }

  restart = "unless-stopped"
}

# Container Redis 7
resource "docker_container" "redis" {
  name  = "bjsports_redis_lab"
  image = docker_image.redis.image_id

  command = ["redis-server", "--appendonly", "yes"]

  ports {
    internal = 6379
    external = var.redis_port
  }

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }

  networks_advanced {
    name = docker_network.bjsports_lab_net.name
  }

  restart = "unless-stopped"
}

# Container Adminer (Interface Web de gestão de Banco)
resource "docker_container" "adminer" {
  name  = "bjsports_adminer_lab"
  image = docker_image.adminer.image_id

  ports {
    internal = 8080
    external = var.adminer_port
  }

  networks_advanced {
    name = docker_network.bjsports_lab_net.name
  }

  restart = "unless-stopped"
}
