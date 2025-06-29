resource "aws_db_instance" "snapcast-db" {
  identifier             = "${var.NOME}-db"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = "${var.user}"
  password               = "${var.senha}" # Alterar para uma senha segura
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  # Para o nível gratuito, use armazenamento magnético
  storage_type = "gp2"

  tags = {
    projeto = var.TAGS
  }

  db_name = "${var.NOME}"
}

output "rds_endpoint" {
  value = aws_db_instance.snapcast-db.address
}


