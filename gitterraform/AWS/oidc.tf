data "aws_region" "current" {}

# OIDC 자격 증명 공급자 생성
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = "https://oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer}"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "9e99a4d2d0b2a2a1f37c1bfbf5d56d81ee2a2b01"  # EKS의 공개 키 지문
  ]
}
