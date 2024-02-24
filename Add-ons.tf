resource "aws_eks_addon" "vpc_cni" {
  addon_name   = "vpc-cni"
  cluster_name = "demo"
  resolve_conflicts = "OVERWRITE"
}

resource "helm_release" "ebs_csi_driver" {
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  name       = "ebs-csi-driver"

  set {
    name  = "enableVolumeScheduling"
    value = "true"
  }

  depends_on = [aws_eks_cluster.demo]
}



