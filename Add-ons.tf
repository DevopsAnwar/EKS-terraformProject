resource "aws_eks_addon" "vpc_cni" {
  addon_name   = "vpc-cni"
  cluster_name = "demo"
  resolve_conflicts = "OVERWRITE"
}

resource "kubernetes_config_map" "ebs_csi_driver_config" {
  metadata {
    name      = "ebs-csi-driver"
    namespace = "kube-system"
  }

  data = {
    "enableVolumeScheduling" = "true"
  }
  depends_on = [aws_eks_cluster.demo]
}



