variable "vpc_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "default_vpc_cidr" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "az" {
  type = list(string)
}
