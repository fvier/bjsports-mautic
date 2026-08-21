output "postgres_connection_string" {
  description = "String de conexão do PostgreSQL do laboratório"
  value       = "postgresql://${var.postgres_user}:${var.postgres_password}@localhost:${var.postgres_port}/${var.postgres_db_name}"
  sensitive   = true
}

output "postgres_container_name" {
  description = "Nome do container PostgreSQL"
  value       = docker_container.postgres.name
}

output "redis_container_name" {
  description = "Nome do container Redis"
  value       = docker_container.redis.name
}

output "adminer_web_url" {
  description = "URL para acesso web ao Adminer (Gestor do PostgreSQL)"
  value       = "http://localhost:${var.adminer_port}"
}

output "lab_network_name" {
  description = "Nome da rede Docker do laboratório"
  value       = docker_network.bjsports_lab_net.name
}
