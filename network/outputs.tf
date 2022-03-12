output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "security_group_id" {
  value = aws_security_group.main.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.database.id
}