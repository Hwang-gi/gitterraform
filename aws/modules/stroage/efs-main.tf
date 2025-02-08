resource "aws_efs_file_system" "efs" {
  creation_token = "${var.vpc_prefix}-efs"
  performance_mode = "generalPurpose"

  tags = {
    Name = "${var.vpc_prefix}-EFS"
  }
}

resource "aws_security_group_rule" "nfs_rule" {
  type = "ingress"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = var.efs_sg_id
}

resource "aws_efs_mount_target" "mount_target" {
  for_each = var.node_subnet_ids
  file_system_id = aws_efs_file_system.efs.id
  subnet_id = each.value
  security_groups = [var.efs_sg_id]
}
