resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url = "https://oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "9e99a8a2bd8f97c0f3b6e0e57cc12c1b0c0f1f52"
  ]
}
