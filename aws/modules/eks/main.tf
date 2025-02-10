data "aws_ssm_parameter" "eks_ami_id" {
  name = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/amazon-linux-2/recommended"
}

locals {
  eks_ami_data = jsondecode(data.aws_ssm_parameter.eks_ami_id.value)
  ami_id       = local.eks_ami_data["image_id"]
  node_groups = {
    "node_group_1" = {
      subnet_ids   = [var.node_subnets[0]]
      node_group_name = "${var.eks_name}-node-group1"
    },
    "node_group_2" = {
      subnet_ids   = [var.node_subnets[1]]
      node_group_name = "${var.eks_name}-node-group2"
    }
  }
}

resource "aws_eks_cluster" "default" {
  name     = "${var.eks_name}"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.node_subnets
    security_group_ids = [var.eks_sg_id]
  }

  depends_on = [
    module.iam
  ]
}

resource "aws_iam_instance_profile" "eks_node_profile" {
  name = "eks-node-instance-profile"
  role = var.node_role_name
}

resource "aws_launch_template" "node_launch_template" {
  name_prefix   = "node-launch-template"
  image_id      = local.ami_id
  instance_type = "t3.large"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.eks_name}
    yum update -y
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.2/2024-07-12/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/
    # aws eks update-kubeconfig --region ${var.region} --name ${var.eks_name}
  EOF
  )

#  iam_instance_profile {
#    name = aws_iam_instance_profile.eks_node_profile.name
#  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20  
      volume_type = "gp2"  
      delete_on_termination = true 
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.node_sg_id] 
  }
}

resource "aws_eks_node_group" "node_group" {
  for_each = local.node_groups

  cluster_name    = var.eks_name
  node_group_name = each.value.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = each.value.subnet_ids 

  ami_type        = "CUSTOM"

  # Launch Template 설정
  launch_template {
    id      = aws_launch_template.node_launch_template.id
    version = "$Latest"  
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"     = "true"
    "k8s.io/cluster-autoscaler/${var.eks_name}" = "owned"
  }

  depends_on = [
    aws_eks_cluster.default,
    var.node_role_arn
  ]
}
