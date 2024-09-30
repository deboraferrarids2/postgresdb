provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

# Definindo o grupo de segurança
resource "aws_security_group" "db_sg" {
  name        = "terraform-20240928151414007800000001"
  description = "Managed by Terraform"
  vpc_id      = "vpc-09812cbad2b7762cb"

  // Defina suas regras de entrada e saída conforme necessário
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
    Name = "db-sg"
  }
}


# Alterar instância do RDS
resource "aws_db_instance" "db" {
  identifier              = "dbinstance"
  engine                  = "postgres"
  engine_version          = "15.7"
  instance_class          = "db.t3.micro"
  allocated_storage        = 20
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  db_subnet_group_name    = "my-db-subnet-group"
  skip_final_snapshot     = true
  deletion_protection     = true
  publicly_accessible      = false
  apply_immediately       = true

   tags = {
    Name = "dbinstance"
  }
}
