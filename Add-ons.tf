resource "aws_eks_addon" "vpc_cni" {
  addon_name   = "vpc-cni"
  cluster_name = "demo"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_csi" {
  addon_name   = "vpc-csi"
  cluster_name = "demo"
  resolve_conflicts = "OVERWRITE"
}





