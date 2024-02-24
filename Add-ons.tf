resource "aws_eks_addon" "vpc_cni" {
  addon_name   = "vpc-cni"
  cluster_name = data.aws_eks_cluster.cluster.id
  resolve_conflicts = "OVERWRITE"
}

