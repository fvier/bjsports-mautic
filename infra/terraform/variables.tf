variable "postgres_db_name" {
  type        = string
  description = "Nome do banco de dados PostgreSQL do laboratório"
  default     = "bjsports_lab_db"
}

variable "postgres_user" {
  type        = string
  description = "Usuário administrativo do PostgreSQL"
  default     = "bjsports_admin"
}

variable "postgres_password" {
  type        = string
  description = "Senha do usuário administrativo do PostgreSQL"
  sensitive   = true
  default     = "bjsports_lab_secret_2026"
}

variable "postgres_port" {
  type        = number
  description = "Porta mapeada no host para o PostgreSQL"
  default     = 5434
}

variable "redis_port" {
  type        = number
  description = "Porta mapeada no host para o Redis"
  default     = 6379
}

variable "adminer_port" {
  type        = number
  description = "Porta mapeada no host para a interface Web do Adminer"
  default     = 8090
}
