# AWS Load Balancer Controller ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "aws_load_balancer_controller_clusterrolebinding" {
  metadata {
    name = "aws-load-balancer-controller-clusterrolebinding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller-sa"
    namespace = "kube-system"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "aws-load-balancer-controller-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}

# Cluster Autoscaler ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "cluster_autoscaler_clusterrolebinding" {
  metadata {
    name = "cluster-autoscaler-clusterrolebinding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "cluster-autoscaler-sa"
    namespace = "kube-system"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "cluster-autoscaler-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}

# EFS CSI Driver ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "efs_csi_driver_clusterrolebinding" {
  metadata {
    name = "efs-csi-driver-clusterrolebinding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "efs-csi-driver-sa"
    namespace = "kube-system"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "efs-csi-driver-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}

# Prometheus ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "prometheus_clusterrolebinding" {
  metadata {
    name = "prometheus-clusterrolebinding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "prometheus-sa"
    namespace = "monitoring"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "prometheus-grafana-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}

# Grafana ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "grafana_clusterrolebinding" {
  metadata {
    name = "grafana-clusterrolebinding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "grafana-sa"
    namespace = "monitoring"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = "prometheus-grafana-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}
