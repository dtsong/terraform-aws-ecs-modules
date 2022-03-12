output "task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}

output "ecs_cluster_arn" {
    value = aws_ecs_service.main.cluster
} 