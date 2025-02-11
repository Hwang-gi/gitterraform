variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "kubernetes_version" {
  type = string
}

variable "eks_name" {
  type = string
}

variable "node_subnets" {
  type = list(string)
}

variable "node_sg_id" {
  type = string
}

variable "eks_sg_id" {
  type = string
}

variable "eks_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "eks_role_name" {
  type = string
}

variable "node_role_name" {
  type = string
}

# Helm Chart 정의하는 Format
# variable {
#   type = map(string)
#   default = {
#   ...
#   }
#}

variable "metrics_server_chart" {
  type        = map(string)
  description = "Metrics Server chart"
  default = {
    name       = "metrics server"
    namespace  = "kube-system"
    repository = "https://kubernetes-sigs.github.io/metrics-server/"
    chart      = "metrics-server"
    version    = "0.7.2"
  }
}

variable "argocd_chart" {
  type        = map(string)
  description = "ArgoCD chart"
  default = {
    name       = "argo"
    namespace  = "argocd"
    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argo"
    version    = "7.8.0"
  }
}

variable "alb_chart" {
  type        = map(string)
  description = "AWS Load Balancer Controller chart"
  default = {
    name       = "aws-load-balancer-controller"
    namespace  = "kube-system"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    version    = "2.11.0"
  }
}

variable "cluster_autoscaler_chart" {
  type = map(string)
  description = "Cluster Autoscaler Chart"
  default = {
    name = "cluster-autoscaler"
    namespace = "kube-system"
    repository = "https://kubernetes.github.io/autoscaler"
    chart = "cluster-autoscaler"
    version = "9.45.0"
  }
}

variable "efs_csi_driver_chart" {
  type = map(string)
  description = "EFS CSI Drvier Chart"
  default = {
    name = "aws-efs-csi-driver"
    namespace = "kube-system"
    repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
    chart = "aws-efs-csi-driver"
    version = "3.1.6"
  }
}

variable "prometheus_chart" {
  type = map(string)
  description = "Prometheus Chart"
  default = {
    name = "prometheus"
    namespace = "monitoring"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "prometheus"
    version = "27.3.0"
  }
}

variable "grafana_chart" {
  type = map(string)
  description = "Grafana Chart"
  default = {
    name = "grafana"
    namespace = "monitoring"
    repository = "https://grafana.github.io/helm-charts"
    chart = "grafana"
    version = "8.9.0"
  }
}
