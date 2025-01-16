resource "aws_launch_template" "node_launch_template" {
  name = "node-launch-template"

  network_interfaces {
    security_groups = [aws_security_group.SG-NODE.id]
  }

    block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }
}

resource "aws_eks_node_group" "eks_cluster1" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "t3_large-node_group1"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = [aws_subnet.PRI-NODE-2A.id, aws_subnet.PRI-NODE-2C.id]

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.vpc_prefix}-Cluster" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  launch_template {
    id = aws_launch_template.node_launch_template.id
    version = "$Latest"
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.large"]
  #capacity_type  = "ON_DEMAND"
  # disk_size = 20


  depends_on = [
    aws_iam_role_policy_attachment.EKS-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.EKS-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.EKS-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.EKS-ElasticLoadBalancingFullAccess
  ]
}

resource "aws_eks_node_group" "eks_cluster2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "t3_large-node_group2"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = [aws_subnet.PRI-NODE-2A.id, aws_subnet.PRI-NODE-2C.id]

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.vpc_prefix}-Cluster" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  launch_template {
    id = aws_launch_template.node_launch_template.id
    version = "$Latest"
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.large"]
  #capacity_type  = "ON_DEMAND"
  # disk_size = 20

  depends_on = [
    aws_iam_role_policy_attachment.EKS-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.EKS-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.EKS-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.EKS-ElasticLoadBalancingFullAccess
  ]
}
