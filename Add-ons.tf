#resource "aws_eks_addon" "vpc_cni" {
#  addon_name   = "vpc-cni"
#  cluster_name = "demo"
#  resolve_conflicts = "OVERWRITE"
#}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
  #  {
  #    name    = "kube-proxy"
  #    version = "v1.21.2-eksbuild.2"
  #  },
    {
      name    = "vpc-cni"
      version = "v1.10.1-eksbuild.1"
    },
   # {
   #   name    = "coredns"
   #   version = "v1.8.4-eksbuild.1"
   # },
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.4.0-eksbuild.preview"
    }
  ]
}
resource "aws_eks_addon" "addons" {
  for_each          = { for addon in var.addons : addon.name => addon }
  cluster_name      = aws_eks_cluster.demo.id
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts = "OVERWRITE"
}
