################################################################################
# RDS Module
################################################################################
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 4.0"

  identifier = var.identifier

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = var.engine
  engine_version       = var.engine_version
  family               = var.family
  major_engine_version = var.major_engine_version
  instance_class       = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  create_random_password = var.create_random_password

  multi_az               = var.multi_az
  vpc_security_group_ids = [var.security_group_id]

  maintenance_window              = var.maintenance_window
  backup_window                   = var.backup_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  create_cloudwatch_log_group     = var.create_cloudwatch_log_group

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  create_monitoring_role                = var.create_monitoring_role
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_name                  = var.monitoring_role_name
  monitoring_role_description           = var.monitoring_role_description

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = var.tags
}

// module "db_default" {
//   source  = "terraform-aws-modules/rds/aws"
//   version = "~> 4.0"

//   identifier = "${var.identifier}-default"

//   create_db_option_group    = false
//   create_db_parameter_group = false

//   # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
//   engine               = var.engine
//   engine_version       = var.engine_version
//   family               = var.family
//   major_engine_version = var.major_engine_version
//   instance_class       = var.instance_class

//   allocated_storage = var.allocated_storage

//   # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
//   # "Error creating DB Instance: InvalidParameterValue: MasterUsername
//   # user cannot be used as it is a reserved word used by the engine"
//   db_name  = var.db_name
//   username = var.db_username
//   password = var.db_password
//   port     = var.db_port

//   db_subnet_group_name   = var.vpc_database_subnet_group
//   vpc_security_group_ids = [var.security_group_id]

//   maintenance_window      = var.maintenance_window
//   backup_window           = var.backup_window
//   backup_retention_period = var.backup_retention_period

//   tags = var.tags
// }
