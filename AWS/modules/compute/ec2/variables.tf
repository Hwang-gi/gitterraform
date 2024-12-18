variable "vpc_name" {
  type    = string
  default = aws_vpc.this.name
}

variable "ubuntu-ami" {
  type    = string
  default = "ami-056a29f2eddc40520"
}

variable "key_name" {
  type    = string
}
