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
  security_group_id = aws_security_group.SG-EFS.id
}

resource "aws_efs_mount_target" "mount_target1" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id = aws_subnet.PRI-NODE-2A.id
  security_groups = [aws_security_group.SG-EFS.id]
}

resource "aws_efs_mount_target" "mount_target2" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id = aws_subnet.PRI-NODE-2C.id
  security_groups = [aws_security_group.SG-EFS.id]
}
