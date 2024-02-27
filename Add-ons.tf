resource "aws_eks_addon" "cni" {
  cluster_name      = "demo"
  addon_name        = "vpc-cni"
  addon_version     = "v1.16.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"

}

resource "aws_eks_addon" "csi" {
  cluster_name      = "demo"
  addon_name        = "aws-ebs-csi-driver"
 # addon_version     = "v1.20.0-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
  replicaCount = 4
  
}
