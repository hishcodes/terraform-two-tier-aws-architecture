resource "aws_security_group" "sg_alb" {
  name        = "sg_alb"
  description = "SG for ALB"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "sg-alb"
  }

  ingress {
    description = "Allow port 80 from internet"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound from ALB"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "sg_instance" {
  name = "sg_instance"
  description = "SG for EC2"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Allow port 80 for SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg_alb.id]
  }

  ingress {
    description = "Allow port 80 for HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg_alb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow port 3306 from instance to db"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    self = false
  }
}

resource "aws_security_group" "db_sg" {
  name = "db_sg"
  description = "SG for RDS DB"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Allow port 3306"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.sg_instance.id]
  }

  egress {
    description = "Allow all ports from DB"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}