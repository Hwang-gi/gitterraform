variable "region" {
  type = string
}

variable "account_id" {
  type = string
  default = "412381775968"
}

variable "vpc_prefix" {
  description = "VPC prefix string"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}

variable "micro_type" {
  description = "t2 micro instance type"
  type        = string
  default     = "t2.micro"
}

variable "node_group_instance_types" {
  description = "Instance types for EKS Node Groups"
  type        = list(string)
  default     = ["t3.large"]
}

variable "node_group_disk_size" {
  description = "Disk size for EKS Node Groups"
  type        = number
  default     = 20
}

variable "ubuntu_ami" {
  description = "custom ubuntu 20.04 AMI"
  type        = string
  default     = "ami-056a29f2eddc40520"
}

variable "cluster_name" {
  description = "Cluster name"
  type = string
}
