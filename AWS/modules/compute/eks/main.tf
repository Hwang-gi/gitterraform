resource "aws_eks_cluster" "this" {
  name     = "${var.vpc_name}-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.manage_eks[0].id,
      aws_subnet.manage_eks[1].id
    ]
  }

  # IAM 역할 정책 연결이 완료된 후 EKS 클러스터를 생성하도록 depends_on 사용
  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController,
  ]
}
