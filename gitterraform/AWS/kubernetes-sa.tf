data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.name
}

data "aws_iam_openid_connect_provider" "oidc_provider" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer  
}

resource "kubernetes_service_account" "alb_sa" {
  metadata {
    name      = "${var.alb_chart.name}-sa"
    namespace = var.alb_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_role.arn
    }
  }
}

resource "kubernetes_service_account" "cluster_autoscaler_sa" {
  metadata {
    name      = "${var.ca_chart.name}-sa"
    namespace = var,ca_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cluster_autoscaler_role.arn
    }
  }
}

resource "kubernetes_service_account" "efs_csi_driver_sa" {
  metadata {
    name      = "${var.efs_chart.name}-sa"
    namespace = var.efs_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.efs_csi_driver_role.arn
    }
  }
}

resource "kubernetes_service_account" "prometheus_sa" {
  metadata {
    name      = "${var.prometheus_chart.name}-sa"
    namespace = var.prometheus_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.prometheus_role.arn
    }
  }
}

resource "kubernetes_service_account" "grafana_sa" {
  metadata {
    name      = "${var.grafana_chart.name}-sa"
    namespace = var.grafana_chart.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.grafana_role.arn
    }
  }
}
