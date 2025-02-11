resource "kubernetes_role" "frontend_backend_monitoring_pods_services" {
  metadata {
    name      = "frontend-backend-monitoring-pods-services"
    namespace = "default"
  }

  rule {
    verbs     = ["get", "list"]
    api_groups = [""]
    resources  = ["pods", "services"]
    namespaces = ["frontend", "backend", "monitoring"]
  }
}

resource "kubernetes_role" "frontend_backend_pods" {
  metadata {
    name      = "frontend-backend-pods"
    namespace = "default"
  }

  rule {
    verbs     = ["create", "update", "delete"]
    api_groups = [""]
    resources  = ["pods"]
    namespaces = ["frontend", "backend"]
  }
}

resource "kubernetes_role" "frontend_backend_deployments" {
  metadata {
    name      = "frontend-backend-deployments"
    namespace = "default"
  }

  rule {
    verbs     = ["get", "list", "create", "update", "delete"]
    api_groups = ["apps"]
    resources  = ["deployments"]
    namespaces = ["frontend", "backend"]
  }
}

resource "kubernetes_role" "backend_persistent_volumes" {
  metadata {
    name      = "backend-persistent-volumes"
    namespace = "default"
  }

  rule {
    verbs     = ["get", "list", "create"]
    api_groups = ["storage.k8s.io"]
    resources  = ["persistentvolumes", "persistentvolumeclaims"]
    namespaces = ["backend"]
  }
}

# You can now bind these roles to specific users or service accounts

resource "kubernetes_role_binding" "frontend_backend_monitoring_pods_services_binding" {
  metadata {
    name      = "frontend-backend-monitoring-pods-services-binding"
    namespace = "default"
  }

  subjects {
    kind      = "User"
    name      = "example-user"
    namespace = "default"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.frontend_backend_monitoring_pods_services.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "frontend_backend_pods_binding" {
  metadata {
    name      = "frontend-backend-pods-binding"
    namespace = "default"
  }

  subjects {
    kind      = "User"
    name      = "example-user"
    namespace = "default"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.frontend_backend_pods.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "frontend_backend_deployments_binding" {
  metadata {
    name      = "frontend-backend-deployments-binding"
    namespace = "default"
  }

  subjects {
    kind      = "User"
    name      = "example-user"
    namespace = "default"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.frontend_backend_deployments.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "backend_persistent_volumes_binding" {
  metadata {
    name      = "backend-persistent-volumes-binding"
    namespace = "default"
  }

  subjects {
    kind      = "User"
    name      = "example-user"
    namespace = "default"
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.backend_persistent_volumes.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
