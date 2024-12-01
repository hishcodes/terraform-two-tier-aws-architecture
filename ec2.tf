data "aws_ami" "amazon_linux_ami" {
  most_recent      = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241121.0-kernel-6.1-x86_64"]
  }
}


resource "aws_instance" "instance_1" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.sg_instance.id]
  key_name = "ec2-key"
  user_data = filebase64("user-data.sh")

  tags = {
    Name = "instance 1"
  }
}

resource "aws_instance" "instance_2" {
  ami = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet_2.id
  security_groups = [aws_security_group.sg_instance.id]
  key_name = "ec2-key"
  user_data = filebase64("user-data.sh")

  tags = {
    Name = "instance 2"
  }
}

