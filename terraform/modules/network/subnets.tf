data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
  total_azs = length(data.aws_availability_zones.azs.names)
}

# === PUBLIC SUBNET === 
resource "aws_subnet" "public" {
  count             = var.public_subnets.cidr == null ? 0 : length(var.public_subnets.cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets.cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index % local.total_azs]
  tags = {
    Name = "${var.public_subnets.name}-${count.index + 1}"
  }
}

# === PRIVATE SUBNET === 
resource "aws_subnet" "private" {
  count             = var.private_subnets.cidr == null ? 0 : length(var.private_subnets.cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets.cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index % local.total_azs]
  tags = {
    "Name" = "${var.private_subnets.name}-${count.index + 1}"
  }
}

# === EKS SUBNET === 
resource "aws_subnet" "eks" {
  count             = var.eks_subnets.cidr == null ? 0 : length(var.eks_subnets.cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.eks_subnets.cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index % local.total_azs]
  tags = {
    "Name"                                                  = "${var.eks_subnets.name}-${count.index + 1}"
    "kubernetes.io/cluster/${var.eks_subnets.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                                = 1
  }
}
