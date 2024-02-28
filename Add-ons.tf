#resource "aws_eks_addon" "cni" {
#  cluster_name      = "demo"
#  addon_name        = "vpc-cni"
#  addon_version     = "v1.16.0-eksbuild.1"
#  resolve_conflicts = "OVERWRITE"
#}

#resource "aws_eks_addon" "csi" {
#  cluster_name      = "demo"
#  addon_name        = "aws-ebs-csi-driver"
#  addon_version     = "v1.20.0-eksbuild.1"
#  resolve_conflicts = "OVERWRITE"
#}

#resource "aws_eks_addon" "ebs-csi" {
#  cluster_name             = "demo"
#  addon_name               = "aws-ebs-csi-driver"
#  addon_version            = "v1.20.0-eksbuild.1"
#  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
#  tags = {
#    "eks_addon" = "ebs-csi"
#    "terraform" = "true"
#  }
#}
