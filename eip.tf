resource "aws_eip" "eip_demo" {
  instance   = aws_instance.web.id
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

}