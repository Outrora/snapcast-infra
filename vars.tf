variable "regionDefault" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}


variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}


variable "instanceType" {
  default = "t3.medium"
}

variable "principalArn" {
  default = "arn:aws:iam::104620867706:role/voclabs"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "NOME" {}

variable "TAGS" {}


