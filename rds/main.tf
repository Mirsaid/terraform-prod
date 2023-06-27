resource "aws_db_instance" "rds_mysql_db" {
  identifier              = "mysql-db-instance"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  db_name                 = var.DB_NAME
  multi_az                = false
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.rds_sg_id] 

  db_subnet_group_name = var.rds_subnet_group_id

  tags = {
    Name = "rds_mysql_db"
  }
}