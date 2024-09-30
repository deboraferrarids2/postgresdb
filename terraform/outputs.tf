output "db_instance_endpoint" {
  value       = aws_db_instance.db.endpoint
  description = "Endpoint do banco de dados RDS"
}

output "db_instance_id" {
  value       = aws_db_instance.db.id
  description = "ID da instância do banco de dados RDS"
}

output "db_security_group_id" {
  value = aws_security_group.db_sg.id
}
