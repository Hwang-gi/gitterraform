resource "aws_eks_node_group" "Node-Group1" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "t3_large-node_group"
  node_role_arn   = aws_iam_role.Node-Group-Role.arn
  subnet_ids      = element(aws_subnet.eks_node, count.index)

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.vpc_name}-cluster" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.large"]
  #capacity_type  = "ON_DEMAND"
  disk_size = 20

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}

resource "aws_eks_node_group" "Node-Group2" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "t3_large-node_group"
  node_role_arn   = aws_iam_role.Node-Group-Role.arn
  subnet_ids      = element(aws_subnet.eks_node, count.index)

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.vpc_name}-cluster" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.large"]
  #capacity_type  = "ON_DEMAND"
  disk_size = 20

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
