variable "vpc_prefix" {
  type = string
}

variable "rds_sg_id" {
  type = string
}

variable "efs_sg_id" {
  type = string
}

variable "rds_subnet_ids" {
  type = list(string)
}

variable "node_subnet_ids" {
  type = map(string)
}
