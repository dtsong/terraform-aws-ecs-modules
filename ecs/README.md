<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_cluster_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_kms_key.ecs_cluster_logging_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name to define for your container in the task definition | `string` | `"application"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of cpu units used by the task. If the requires\_compatibilities is FARGATE this field is required. | `number` | n/a | yes |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of instances of the task definition. | `number` | n/a | yes |
| <a name="input_ecs_execution_role_arn"></a> [ecs\_execution\_role\_arn](#input\_ecs\_execution\_role\_arn) | ARN of the IAM role for ECS Execution | `string` | n/a | yes |
| <a name="input_ecs_task_role_arn"></a> [ecs\_task\_role\_arn](#input\_ecs\_task\_role\_arn) | ARN of the IAM role for the ECS Task | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The value to pass for NODE\_ENV to be set in the task definition | `string` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | A unique name for your task definition | `string` | `"smartcar-infrastructure-challenge"` | no |
| <a name="input_image"></a> [image](#input\_image) | Valid Docker image reference, needs to be accessible | `string` | `"smartcar/infrastructure-challenge:latest"` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2. | `string` | `"FARGATE"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount (in MiB) of memory used by the task. If the requires\_compatibilities is FARGATE this field is required. | `number` | n/a | yes |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host. | `string` | `"awsvpc"` | no |
| <a name="input_pg_database_hostname"></a> [pg\_database\_hostname](#input\_pg\_database\_hostname) | PostgreSQL Database Hostname | `string` | n/a | yes |
| <a name="input_pg_database_name"></a> [pg\_database\_name](#input\_pg\_database\_name) | Name of database to connect to | `string` | n/a | yes |
| <a name="input_pg_database_password"></a> [pg\_database\_password](#input\_pg\_database\_password) | PostgreSQL Database password | `string` | n/a | yes |
| <a name="input_pg_database_port"></a> [pg\_database\_port](#input\_pg\_database\_port) | PostgreSQL Database Port number | `string` | `5432` | no |
| <a name="input_pg_database_username"></a> [pg\_database\_username](#input\_pg\_database\_username) | PostgreSQL Database user | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The PORT environment variable value to be set to expose the service | `string` | n/a | yes |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | Subnet ID for ECS Service network configuration | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region value to be utilized for the task definition | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of S3 bucket to be passed to task definition as an env variable | `string` | n/a | yes |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | Scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA | `string` | `"REPLICA"` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security Group ID for ECS Service network configuration | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | n/a |
<!-- END_TF_DOCS -->