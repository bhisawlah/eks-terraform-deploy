################################################################################
# General Variables from root module
################################################################################

variable "main-region" {
  type    = string
  default = "us-west-1"
}

variable "env_name" {
  type = string
}

variable "cluster_name" {
  type = string
  default = "dominion-cluster"
}

################################################################################
# Variables from other Modules
################################################################################

variable "vpc_id" {
  description = "VPC ID which Load balancers will be  deployed in"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN used for IRSA "
  type        = string
  default = "https://oidc.eks.us-west-1.amazonaws.com/id/090143FC30CC33519DEECB10D60AA8D5"
}
