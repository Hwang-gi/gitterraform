data "aws_eks_cluster_auth" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_cluster.token
  }
}

resource "terraform_data" "kubeconfig" {
  depends_on = [ aws_eks_cluster.eks_cluster ]

  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
  }
}

resource "helm_release" "aws_load_balancer_controller" {
    name = "aws-load-balancer-controller"

    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    namespace = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks_cluster.name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = aws_iam_role.aws_load_balancer_controller_role.name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller_role.arn
  }

  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }

    depends_on = [
      aws_eks_cluster.eks_cluster
    ]
}

resource "helm_release" "cluster_autoscaler" {
  name = "cluster-autoscaler"

  repository = "https://kubernetes.github.io/autoscaler"
  chart = "cluster-autoscaler"
  namespace = "kube-system"

  set {
    name = "controller.serviceAccount.name"
    value = "cluster-autoscaler-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks.amazonaws.com/role-arn"
    value = aws_iam_role.cluster_autoscaler_role.arn
  }
}

resource "helm_release" "prometheus" {
  name = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "prometheus"
  namespace = "monitoring"

  create_namespace = true



  set {
    name = "controller.serviceAccount.name"
    value = "prometheus-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks.amazonaws.com/role-arn"
    value = aws_iam_role.prometheus_role.arn
  }
}

resource "helm_release" "grafana" {
  name = "grafana"

  repository = "https://grafana.github.io/helm-charts"
  chart = "grafana"
  namespace = "monitoring"

  create_namespace = true



  set {
    name = "controller.serviceAccount.name"
    value = "grafana-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks.amazonaws.com/role-arn"
    value = aws_iam_role.grafana_role.arn
  }
}
