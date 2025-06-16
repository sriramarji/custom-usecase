variable "my-amiid" {
  description = "EC2 ami id"
  type        = string
  #default     = "ami-084568db4383264d4"
  default = "ami-020cba7c55df1f615"
}

variable "my-instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "my-keyname" {
  description = "EC2 instance key pair"
  type        = string
  default     = "Hcl-prac-training"
}