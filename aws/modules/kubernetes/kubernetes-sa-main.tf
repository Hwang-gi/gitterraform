resource "kubernetes_service_account" "eks_sa" {
  metadata {
    name      = "eks-sa"
    namespace = "default"
  }
}

resource "kubernetes_service_account" "node_sa" {
  metadata {
    name      = "eks-sa"
    namespace = "default"
  }
}
