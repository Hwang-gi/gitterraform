data "aws_eks_cluster" "default" {
  name = aws_eks_cluster.default.name
}

data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.default.name
}
  
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}

resource "helm_release" "metrics_server_chart" {
  name       = var.metrics_server_chart.name
  namespace  = var.metrics_server_chart.namespace
  repository = var.metrics_server_chart.repository
  chart      = var.metrics_server_chart.chart
  version    = var.metrics_server_chart.version

  values = [
    enableServiceMutatorWebhook: true
  ]
}

resource "helm_release" "argocd_chart" {
  name       = var.argocd_chart.name
  namespace  = var.argocd_chart.namespace
  repository = var.argocd_chart.repository
  chart      = var.argocd_chart.chart
  version    = var.argocd_chart.version

  values = [
    <<-EOT
    controller:
      webhook:
        url: "https://argocd.example.com/api/webhook"
        secret: "argocd-webhook-secret"
    EOT    
  ]
}

resource "helm_release" "alb_chart" {
  name       = var.alb_chart.name
  namespace  = var.alb_chart.namespace
  repository = var.alb_chart.repository
  chart      = var.alb_chart.chart
  version    = var.alb_chart.version

  values = [
    <<-EOT
    clusterName: ${data.aws_eks_cluster.default.name}
    enableServiceMutatorWebhook: true
    EOT
  ]
}

resource "helm_release" "cluster_autoscaler_chart" {
  name = var.cluster_autoscaler_chart.name
  namespace = var.cluster_autoscaler_chart.namespace
  repository = var.cluster_autoscaler_chart.repository
  chart = var.cluster_autoscaler_chart.chart
  version = var.cluster_autoscaler_chart.version
}

resource "helm_release" "efs_csi_driver_chart" {
  name = var.efs_csi_driver_chart.name
  namespace = var.efs_csi_driver_chart.namespace
  repository = var.efs_csi_driver_chart.repository
  chart = var.efs_csi_driver_chart.chart
  version = var.efs_csi_driver_chart.version
}

resource "helm_release" "prometheus_chart" {
  name = var.prometheus_chart.name
  namespace = var.prometheus_chart.namespace
  repository = var.prometheus_chart.repository
  chart = var.prometheus_chart.chart
  version = var.prometheus_chart.version

  values = [
    enableServiceMutatorWebhook: true
  ]
}

resource "helm_release" "grafana_chart" {
  name = var.grafana_chart.name
  namespace = var.grafana_chart.namespace
  repository = var.grafana_chart.repository
  chart = var.grafana_chart.chart
  version = var.grafana_chart.version
}
