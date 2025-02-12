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

# prometheus Clusterrole
resource "kubernetes_cluster_role" "prometheus_grafana_clusterrole" {
  metadata {
    name = "prometheus-grafana-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "endpoints", "nodes", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["deployments", "replicasets", "daemonsets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets", "replicasets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }
}

# Authorization Configuration (RBAC Rules)
resource "kubernetes_cluster_role" "frontend_backend_monitoring_pods_services" {
  metadata {
    name = "frontend-backend-monitoring-pods-services"
  }

  rule {
    verbs     = ["get", "list"]
    api_groups = [""]
    resources  = ["pods", "services"]
  }
}

resource "kubernetes_cluster_role" "frontend_backend_pods" {
  metadata {
    name = "frontend-backend-pods"
  }

  rule {
    verbs     = ["create", "update", "delete"]
    api_groups = [""]
    resources  = ["pods"]
  }
}

resource "kubernetes_cluster_role" "frontend_backend_deployments" {
  metadata {
    name = "frontend-backend-deployments"
  }

  rule {
    verbs     = ["get", "list", "create", "update", "delete"]
    api_groups = ["apps"]
    resources  = ["deployments"]
  }
}

resource "kubernetes_cluster_role" "backend_persistent_volumes" {
  metadata {
    name = "backend-persistent-volumes"
  } 

  rule {
    verbs     = ["get", "list", "create"]
    api_groups = ["storage.k8s.io"]
    resources  = ["persistentvolumes", "persistentvolumeclaims"]
  }
}
