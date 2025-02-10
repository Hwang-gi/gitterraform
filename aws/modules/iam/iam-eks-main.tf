resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}:sub": "system:serviceaccount:default:eks-sa"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "autoscaler_role" {
  name = "cluster-autoscaler-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}:sub": "system:serviceaccount:kube-system:cluster-autoscaler-sa"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "efs_csi_driver_role" {
  name = "efs-csi-driver-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}:sub": "system:serviceaccount:kube-system:efs-csi-driver-sa"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "aws_load_balancer_controller_role" {
  name = "aws-load-balancer-controller-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_id}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller-sa"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  policy_arn = aws_iam_policy.eks_policy.arn
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "CA_Policy" {
  policy_arn = aws_iam_policy.Autoscaler_Policy.arn
  role       = aws_iam_role.autoscaler_role.name
}

resource "aws_iam_role_policy_attachment" "EFS_CSI_Driver_Policy" {
  policy_arn = aws_iam_policy.EFS_CSI_Driver_Policy.arn
  role       = aws_iam_role.efs_csi_driver_role.name
}

resource "aws_iam_role_policy_attachment" "ALB_Policy" {
  policy_arn = aws_iam_policy.ALB_Policy.arn
  role       = aws_iam_role.aws_load_balancer_controller_role.name
}
