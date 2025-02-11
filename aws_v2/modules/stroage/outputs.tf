output "frontend_ecr_arn" {
  value = length(aws_ecr_repository.frontend) > 0 ? aws_ecr_repository.frontend[0].arn : null
}

output "backend_ecr_arn" {
  value = length(aws_ecr_repository.backend) > 0 ? aws_ecr_repository.backend[0].arn : null
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
}

output "efs_mount_target_subnet_ids" {
  value = [for target in aws_efs_mount_target.mount_target : target.subnet_id]
}

output "rds_db_subnet_group_id" {
  value = aws_db_subnet_group.DB_SUBG.id
}

output "rds_db_instance_endpoint" {
  value = aws_db_instance.rds_master.endpoint
}
