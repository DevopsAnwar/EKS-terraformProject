resource "aws_eks_addon" "vpc_cni" {
  addon_name   = "vpc-cni"
  cluster_name = data.aws_eks_cluster.cluster.id
  resolve_conflicts = "OVERWRITE"
}

# Create an IAM Role to be assumed by ExternalDNS
ebs_csi_addon_role = iam.Role(
    self,
    'EbsCsiAddonRole',
     # for Role's Trust relationships
    assumed_by=iam.FederatedPrincipal(
         federated=oidc_provider_arn,
         conditions={
              'StringEquals': {
                f'{oidc_provider_url.replace("https://", "")}:sub': 'system:serviceaccount:kube-system:ebs-csi-controller-sa'
             }
         },
         assume_role_action='sts:AssumeRoleWithWebIdentity'
     )
)
ebs_csi_addon_role.add_managed_policy(iam.ManagedPolicy.from_aws_managed_policy_name("service-role/AmazonEBSCSIDriverPolicy"))

# Add EBS CSI add-on
ebs_csi_addon = eks.CfnAddon(
    self,
    "EbsCsiAddonSa",
    addon_name="aws-ebs-csi-driver",
    cluster_name=cluster_name,
    resolve_conflicts="OVERWRITE",
    addon_version="v1.20.0-eksbuild.1",
    service_account_role_arn=ebs_csi_addon_role.role_arn
)

