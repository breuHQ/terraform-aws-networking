variable name {
  description = "Name of Resource"
  type        = string
}

variable cidr_block {
  description = "CIDR block of vpc"
  type        = string
}

variable enable_dns_hostnames {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable enable_dns_support {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable public_subnets {
  description = "Public subnets"
  type        = list(string)
}

variable private_subnets {
  description = "Private subnets"
  type        = list(string)
}

variable environment {
  description = "Environment of resource"
  type        = string
}
