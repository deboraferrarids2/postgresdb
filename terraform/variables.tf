variable "db_username" {
  description = "Usuário do banco de dados RDS"
}

variable "db_password" {
  description = "Senha do banco de dados RDS"
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco de dados"
  default     = "challengedb"
}

variable "vpc_id" {
  description = "O ID da VPC onde o RDS será criado"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets privadas"
  type        = list(string)
}
