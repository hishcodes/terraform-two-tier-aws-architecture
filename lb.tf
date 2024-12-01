resource "aws_lb" "alb" {
  name = "alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.sg_alb.id]
  subnets = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}

resource "aws_lb_target_group" "my_tg" {
  name = "my-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "tg_attachment_1" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id = aws_instance.instance_1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_2" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id = aws_instance.instance_2.id
  port = 80
}

