output "alb_dns_name" {
    value = aws_lb.alb.dns_name
}

output "aws_db_instance" {
  value = aws_db_instance.rds_1.endpoint
}