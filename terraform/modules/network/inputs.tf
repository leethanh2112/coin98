variable "vpc_cidr" {
  type        = string
  description = "The cidr of VPC."
}

variable "public_subnets" {
  type = object({
    name     = string
    rtb_name = string
    cidr     = list(string)
  })
  description = "The list cidr of public subnet."
}

variable "private_subnets" {
  type = object({
    name     = string
    rtb_name = string
    cidr     = list(string)
  })
  description = "The list cidr of private subnet."
}

variable "eks_subnets" {
  type = object({
    cluster_name = string
    name         = string
    rtb_name     = string
    cidr         = list(string)
  })
  description = "The list cidr of eks subnet."
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "natgw_name" {
  type = string
}

variable "natgw_eip_name" {
  type = string
}

