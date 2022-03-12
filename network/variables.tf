variable "cidr_block" {
  description = "CIDR Block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR Block for Public Subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR Block for Private Subnet"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of DB Subnet Group to be created"
  type        = string
}

variable "security_group_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "enable_dns_support" {
  description = "true/false to toggle DNS support for VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "true/false to toggle DNS Hostnames for VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "true/false to toggle whether to map an IP on launch or not"
  type        = bool
  default     = true
}
