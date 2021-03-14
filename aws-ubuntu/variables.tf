variable "profile" {
  description = "AWS profile name for CLI"
  default     = "root"
}

variable "region" {
  description = "AWS region for infrastructure."
  default     = "us-east-1"
}

variable "ami_name" {
  description = "Name of AMI"
  type        = string
}

variable "vpc_name" {
  description = "VPC name tag value."
  default     = "vpc"
}

variable "cidr_block" {
  description = "CIDR block for VPC."
  default     = "10.0.0.0/16"
}

variable "cidrs" {
  description = "CIDR blocks for subnets."
  default     = "10.0.1.0/24"
}

variable "azs" {
  description = "Availability zones for subnets."
  default     = "b"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_vol_type" {
  description = "EC2 volume type"
  type        = string
  default     = "gp2"
}

variable "instance_vol_size" {
  description = "EC2 volume size"
  type        = number
  default     = 20
}

variable "instance_subnet" {
  description = "EC2 subnet serial"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Name of key"
  type        = string
}

