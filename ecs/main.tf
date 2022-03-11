resource "aws_cloudwatch_log_group" "main" {
  name = "/ecs/${var.family}"
}

resource "aws_ecs_task_definition" "main" {
  family = var.family
  container_definitions = jsonencode(
    [
      {
        name      = var.application_name
        image     = var.image
        essential = true
        environment = [
          {
            name  = "NODE_ENV"
            value = "production"
          },
          {
            name  = "PORT"
            value = "5555"
          },
          {
            name  = "AWS_REGION"
            value = var.region
          },
          {
            name  = "S3_BUCKET_NAME"
            value = var.s3_bucket_name
          },
        ],
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = aws_cloudwatch_log_group.main.name
            awslogs-region        = var.region
            awslogs-stream-prefix = var.application_name
          }
        }
      }
  ])

  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_execution_arn
  task_role_arn            = var.ecs_task_arn
  network_mode             = "awsvpc"
  requires_compatibilities = [var.launch_type]
}

resource "aws_ecs_service" "main" {
  name          = var.family
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
  name = var.family
}
