resource "aws_cloudwatch_log_group" "ecs_task" {
  name = "/ecs/${var.family}"
}

resource "aws_ecs_task_definition" "main" {
  family = "${var.family}-task-definition"
  container_definitions = jsonencode(
    [
      {
        name      = var.application_name
        image     = var.image
        essential = true
        environment = [
          {
            name  = "NODE_ENV"
            value = var.environment
          },
          {
            name  = "PORT"
            value = var.port
          },
          {
            name  = "AWS_REGION"
            value = var.s3_region
          },
          {
            name  = "S3_BUCKET_NAME"
            value = var.s3_bucket_name
          },
          {
            name  = "PGHOST"
            value = var.pg_database_hostname
          },
          {
            name  = "PGPORT"
            value = var.pg_database_port
          },
          {
            name  = "PGUSER"
            value = var.pg_database_username
          },
          {
            name  = "PGPASSWORD"
            value = var.pg_database_password
          },
          {
            name  = "PGDATABASE"
            value = var.pg_database_name
          },
        ],
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.ecs_task.name
            awslogs-region        = var.s3_region
            awslogs-stream-prefix = var.application_name
          }
        }
      }
  ])

  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = [var.launch_type]
}

resource "aws_ecs_service" "main" {
  name          = "${var.family}-ecs-service"
  cluster       = aws_ecs_cluster.main.arn
  desired_count = var.desired_count
  launch_type   = var.launch_type

  network_configuration {
    subnets          = [var.public_subnet_id]
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  scheduling_strategy   = var.scheduling_strategy
  task_definition       = aws_ecs_task_definition.main.arn
  wait_for_steady_state = false
}

resource "aws_ecs_cluster" "main" {
  name = "${var.family}-ecs-cluster"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs_cluster_logging_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_cluster_logs.name
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs_cluster_logs" {
  name = "/ecs-cluster/${var.family}"
}

resource "aws_kms_key" "ecs_cluster_logging_key" {
  description             = "example"
  deletion_window_in_days = 7
}
