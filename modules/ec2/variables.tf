variable "ami_id" {
  description = "ID of the VPC"
  type        = string
}

variable "instance_type" {
  description = "Provide your instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 instance key pair"
  type        = string
}