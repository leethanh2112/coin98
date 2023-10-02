module "network" {
  source = "./modules/network"
  vpc_cidr         = "10.0.0.0/16"
  vpc_name         = "coin98"
  igw_name         = "coin98-igw"
  natgw_name       = "coin98-natgw"
  natgw_eip_name   = "coin98-natgw-eip"


  public_subnets = {
    name     = "coin98-public-subnet"
    rtb_name = "coin98-public-subnet-rtb"
    cidr     = ["10.8.11.0/24", "10.8.12.0/24", "10.8.13.0/24"]
  }

  private_subnets = {
    name     = "coin98-private-subnet"
    rtb_name = "coin98-private-subnet-rtb"
    cidr     = ["10.8.21.0/24", "10.8.22.0/24", "10.8.23.0/24"]
  }

  eks_subnets = {
    name         = "coin98-eks-subnet"
    rtb_name     = "coin98-eks-subnet-rtb"
    cidr         = ["10.8.30.0/23", "10.8.32.0/23", "10.8.34.0/23"]
  }

}

