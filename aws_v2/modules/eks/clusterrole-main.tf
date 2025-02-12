# AWS Load Balancer Controller ClusterRole
resource "kubernetes_cluster_role" "aws_load_balancer_controller_clusterrole" {
  metadata {
    name = "aws-load-balancer-controller-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "pods"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "ingresses/status"]
    verbs      = ["get", "list", "create", "update", "delete", "patch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "create", "update", "delete", "patch"]
  }

  rule {
    api_groups = ["elasticloadbalancing.k8s.io"]
    resources  = ["targetgroupbindings"]
    verbs      = ["get", "list", "create", "update", "delete"]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["roles", "rolebindings"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "list"]
  }
}

# Cluster Autoscaler ClusterRole
resource "kubernetes_cluster_role" "cluster_autoscaler_clusterrole" {
  metadata {
    name = "cluster-autoscaler-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "nodes", "services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources  = ["replicasets", "horizontalpodautoscalers"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["replicasets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["nodes/status"]
    verbs      = ["get", "update"]
  }
}

# EFS CSI Driver ClusterRole
resource "kubernetes_cluster_role" "efs_csi_driver_clusterrole" {
  metadata {
    name = "efs-csi-driver-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "persistentvolumes", "services"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses", "persistentvolumes"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["cloudprovider.k8s.io"]
    resources  = ["cloudproviders"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["efs.csi.k8s.io"]
    resources  = ["efsfs"]
    verbs      = ["get", "list", "watch", "create"]
  }
}
