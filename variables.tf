variable "private_subnets" {
  type = map
  default = {
    a = "10.0.11.0/24"
    b = "10.0.12.0/24"
    c = "10.0.13.0/24"
  }
}

variable "subnets" {
  description = "Default values for public subnets."
  type        = map
  default = {
    a = "10.0.14.0/24"
    b = "10.0.15.0/24"
    c = "10.0.16.0/24"
  }
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map
  default = {
    archuuid = "a5875f98-dfc1-4882-8e97-f9fde1b6f0db"
    env      = "Development"
  }
}

variable "vpc_cidr" {
  description = "The network addressing for the default VPC."
  type        = string
  default     = "10.0.0.0/16"
}

