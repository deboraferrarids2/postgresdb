provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

# Definindo o grupo de segurança
resource "aws_security_group" "db_sg" {
  name        = "terraform-20241001005918254900000003"
  description = "Managed by Terraform"
  vpc_id      = "vpc-0add8518b58c7b20b"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Permitir acesso de dentro da VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir saída para qualquer lugar
  }

  tags = {
    Name = "db-sg-v2"
  }
}


# Alterar instância do RDS
resource "aws_db_instance" "db_v2" {
  identifier              = "dbinstance-v2"
  engine                  = "postgres"
  engine_version          = "15.7"
  instance_class          = "db.t3.micro"
  allocated_storage        = 20
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  vpc_security_group_ids  = [aws_security_group.db_sg_v2.id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group_v2.name 
  skip_final_snapshot     = true
  deletion_protection     = true
  publicly_accessible      = false
  apply_immediately       = true

   tags = {
    Name = "dbinstance-v2"
  }
}
