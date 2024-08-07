################################################################################
# General Variables from root module
################################################################################
variable "cluster_name" {
  type    = string
  default = "dominion-cluster"
}

################################################################################
# Variables from other Modules
################################################################################

variable "vpc_id" {
  description = "VPC ID which EKS cluster is deployed in"
  type        = string
  default = "vpc-028dc4ae499efec21"
}

variable "private_subnets" {
  description = "VPC Private Subnets which EKS cluster is deployed in"
  type        = list(any)
}

################################################################################
# Variables defined using Environment Variables
################################################################################

variable "rolearn" {
  description = "Add admin role to the aws-auth configmap"
  type = string
  default = "arn:aws:iam::339712774185:role/kops"
}

