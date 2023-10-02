# === Public subnet Route table === 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.public_subnets.rtb_name
  }
}

resource "aws_route_table_association" "public_rta" {
  route_table_id = aws_route_table.public.id
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  depends_on = [
    aws_route_table.public
  ]
}


# === Private subnet Route table === 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = var.private_subnets.rtb_name
  }
}

resource "aws_route_table_association" "private_rta" {
  route_table_id = aws_route_table.private.id
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  depends_on = [
    aws_route_table.private
  ]
}


# === EKS subnet Route table === 
resource "aws_route_table" "eks" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    Name = var.eks_subnets.rtb_name
  }
}

resource "aws_route_table_association" "eks_rta" {
  route_table_id = aws_route_table.eks.id
  count          = length(aws_subnet.eks)
  subnet_id      = aws_subnet.eks[count.index].id
  depends_on = [
    aws_route_table.eks
  ]
}
