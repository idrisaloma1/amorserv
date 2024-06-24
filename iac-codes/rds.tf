# main.tf

resource "aws_db_instance" "amorserv_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  # name                 = "mydatabase" # Uncomment if you want to specify a database name
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.amorserv_sg.id]
  db_subnet_group_name = aws_db_subnet_group.amorserv.name
  skip_final_snapshot  = true
}

# This resource creates a database subnet group for the amorsev service.
# It includes two private subnets for high availability.
resource "aws_db_subnet_group" "amorserv" {
  name       = "amorserv_db_subnet_group"
  subnet_ids = [aws_subnet.amorserv_private_subnet_1.id, aws_subnet.amorserv_private_subnet_2.id]
  
  tags = {
    Name = "amorserv_db_subnet_group"
  }
}



