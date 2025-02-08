variable "kubernetes_version" {
  type = string
}

variable "eks_name" {
  type = string
}

variable "node_subnets" {
  type = list(string)
}

variable "node_sg_name" {
  type = string
}

variable "eks_sg_id" {
  type = string
}

variable "eks_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "eks_role_name" {
  type = string
}

variable "node_role_name" {
  type = string
}
