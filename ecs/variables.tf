# Dependency variables (from other modules)
variable "s3_bucket_name" {
  description = "Name of S3 bucket to be passed to task definition as an env variable"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ID for ECS Service network configuration"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for ECS Service network configuration"
  type        = string
}

variable "ecs_execution_role_arn" {
  description = "ARN of the IAM role for ECS Execution"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the IAM role for the ECS Task"
  type        = string
}

# Database variables (to be set as container environment variables)
variable "pg_database_hostname" {
  description = "PostgreSQL Database Hostname"
  type        = string
  sensitive   = true
}

variable "pg_database_port" {
  description = "PostgreSQL Database Port number"
  type        = string
  default     = 5432
}

variable "pg_database_username" {
  description = "PostgreSQL Database user"
  type        = string
  sensitive   = true
}

variable "pg_database_password" {
  description = "PostgreSQL Database password"
  type        = string
  sensitive   = true
}

variable "pg_database_name" {
  description = "Name of database to connect to"
  type        = string
  sensitive   = true
}

# ECS Task Definition
variable "family" {
  description = "A unique name for your task definition"
  type        = string
  default     = "smartcar-infrastructure-challenge"
}

variable "application_name" {
  description = "Name to define for your container in the task definition"
  type        = string
  default     = "application"
}

variable "image" {
  description = "Valid Docker image reference, needs to be accessible"
  type        = string
  default     = "smartcar/infrastructure-challenge:latest"
}

variable "environment" {
  description = "The value to pass for NODE_ENV to be set in the task definition"
  type        = string
}

variable "service_port" {
  description = "The PORT environment variable value to be set to expose the service"
  type        = string
}

variable "region" {
  description = "The AWS region value to be utilized for the task definition"
  type        = string
}

variable "cpu" {
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "awsvpc"
}

variable "desired_count" {
  description = "Number of instances of the task definition."
  type        = number
}

variable "launch_type" {
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2."
  type        = string
  default     = "FARGATE"
}

# Note on DAEMON support: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
variable "scheduling_strategy" {
  description = "Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA"
  type        = string
  default     = "REPLICA"
}
