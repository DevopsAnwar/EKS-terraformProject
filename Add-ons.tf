  cluster_addons = {
    #coredns = {
    #  addon_version = "v1.8.7-eksbuild.3"
    #  resolve_conflicts = "OVERWRITE"
    #}
    #kube-proxy = {
    #  addon_version = "v1.24.7-eksbuild.2"
    #  resolve_conflicts = "OVERWRITE"
    #}
    vpc-cni = {
      addon_version = "v1.12.0-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      addon_version = "v1.13.0-eksbuild.2"
      resolve_conflicts="PRESERVE"
    }
  }





