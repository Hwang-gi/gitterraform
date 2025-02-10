resource "kubernetes_service_account" "eks_sa" {
  metadata {
    name      = "eks-sa"
    namespace = "default"
  }
}

resource "kubernetes_service_account" "node_sa" {
  metadata {
    name      = "eks-node-sa"
    namespace = "default"
  }
}

resource "kubernetes_role" "read_only_role" {
  metadata {
    name      = "read-only-role"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_role_binding" "read_only_role_binding" {
  metadata {
    name      = "read-only-role-binding"
    namespace = "default"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.eks_sa.metadata[0].name
    namespace = "default"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.read_only_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role" "view_cluster_resources" {
  metadata {
    name = "view-cluster-resources"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "nodes", "namespaces"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_cluster_role_binding" "view_cluster_resources_binding" {
  metadata {
    name = "view-cluster-resources-binding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.eks_sa.metadata[0].name
    namespace = "default"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = kubernetes_cluster_role.view_cluster_resources.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
