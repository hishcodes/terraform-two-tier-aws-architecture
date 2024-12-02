# Two tier architecture using Terraform on AWS

![architectural-diagram](/architecture.webp)

This Terraform project uses VPC, subnets, route tables, Internet gateway, application load balancer, security groups for load balancer, instance and RDS DB. Also we use RDS DB instance in private subnet.

The DNS name is printed in the terminal, which opens a web page displaying the internet ip address of respective ec2 instances.