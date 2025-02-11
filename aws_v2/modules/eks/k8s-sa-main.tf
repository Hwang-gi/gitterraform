# AWS Load Balancer Controller ServiceAccount
resource "kubernetes_service_account" "aws_load_balancer_controller_sa" {
  metadata {
    name      = "aws-load-balancer-controller-sa"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# Cluster Autoscaler ServiceAccount
resource "kubernetes_service_account" "cluster_autoscaler_sa" {
  metadata {
    name      = "cluster-autoscaler-sa"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# EFS CSI Driver ServiceAccount
resource "kubernetes_service_account" "efs_csi_driver_sa" {
  metadata {
    name      = "efs-csi-driver-sa"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# Prometheus ServiceAccount
resource "kubernetes_service_account" "prometheus_sa" {
  metadata {
    name      = "prometheus-sa"
    namespace = "monitoring"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}

# Grafana ServiceAccount
resource "kubernetes_service_account" "grafana_sa" {
  metadata {
    name      = "grafana-sa"
    namespace = "monitoring"
    annotations = {
      "kubernetes.io/enforce-mountable-secrets" = "true"
    }
  }
}
