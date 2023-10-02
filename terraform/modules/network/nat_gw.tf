# === NAT GW === 
resource "aws_eip" "nat_eip" {
  tags = {
    "Name" = var.natgw_eip_name
  }
}

resource "aws_nat_gateway" "natgw" {
  subnet_id     = aws_subnet.public.0.id
  allocation_id = aws_eip.nat_eip.id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    "Name" = var.natgw_name
  }
}
