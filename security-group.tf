resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow Ingress rules to allow SSH and HTTP connections"
  vpc_id      = aws_vpc.vpc_demo.id
}  