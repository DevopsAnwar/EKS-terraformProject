resource "aws_eks_addon" "cni" {
  cluster_name      = "demo"
  addon_name        = "vpc-cni"
  addon_version           = "v1.16.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

}

resource "aws_eks_addon" "csi" {
  cluster_name      = "demo"
  addon_name        = "vpc-ebs-csi-drive"
  addon_version           = "v1.28.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

}
