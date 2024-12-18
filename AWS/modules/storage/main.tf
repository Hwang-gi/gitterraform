# mariadb Parameter Group 설정
resource "aws_db_parameter_group" "mariadb-parameter" {
  name        = "mariadb-parameter-group"
  family      = "mariadb10.11"
  description = "Custom parameter group for MariaDB"

  parameter {
    name  = "max_connections"
    value = "150"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }


  parameter {
    name  = "binlog_format"
    value = "ROW"
  }
}

# DB 구성 (RDS 이름: 소문자로 시작해야)
resource "aws_db_instance" "rds-master" {
  identifier_prefix      = "rds-master"
  allocated_storage      = 10
  engine                 = "mariadb"
  engine_version         = "10.11.8"
  instance_class         = "db.t3.micro"
  db_name                = "prd_mariadb"
  username               = "boss"
  password               = "sd12!fg34"
  parameter_group_name   = "mariadb-parameter"
  skip_final_snapshot    = true
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "${var.vpc_name}rds-master"
  }
}
