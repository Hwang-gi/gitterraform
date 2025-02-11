variable "vpc_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "ubuntu_ami" {
  type = string
  default = "ami-056a29f2eddc40520"
}

variable "micro_type" {
  type = string
  default = "t3.micro"
}

variable "key_pair_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "bastion_subnet_ids" {
  type = list(string)
}

variable "eks_managed_subnet_ids" {
  type = list(string)
}

variable "efs_managed_subnet_id" {
  type = string
}

variable "argocd_subnet_id" {
  type = string
}

variable "ngw_ids" {
  type = list(string)
}

variable "sg_bastion_id" {
  type = string
}


variable "sg_eks_managed_id" {
  type = string
}

variable "sg_efs_managed_id" {
  type = string
}

variable "sg_argocd_id" {
  type = string
}

# variable "sg_redis_id" {
#   type = string
# }
