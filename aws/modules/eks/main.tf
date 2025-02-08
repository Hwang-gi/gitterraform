data "aws_ssm_parameter" "eks_ami_id" {
  name = "/aws/service/eks/optimized-ami/1.31/amazon-linux-2/recommended"
}

resource "aws_eks_cluster" "default" {
  name     = "${var.eks_name}"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.node_subnets
    security_group_ids = [var.eks_sg_id]
  }

  depends_on = [
    var.eks_role_name
  ]
}

resource "aws_launch_template" "node_launch_template" {
  name_prefix   = "node-launch-template"
  image_id      = jsondecode(data.aws_ssm_parameter.eks_ami_id.value).image_id
  instance_type = "t3.large"
  security_group_names = [var.node_sg_id]

}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.eks_name
  node_group_name = "${var.eks_name}-node-group1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.node_subnets

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.eks_name}" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  ami_type       = "CUSTOM"
  instance_types = ["t3.large"]
  #capacity_type  = "ON_DEMAND"
  disk_size = 20

  depends_on = [
    var.node_role_name
  ]
}
