module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "beginner-eks-cluster"
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access           = true
  
  # Keep this! This automatically handles DavidUser00
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    workers = {
      min_size     = 1
      max_size     = 2
      desired_size = 2
      instance_types = ["t3.small"]
    }
  }

  # Clear out your own identity here since the flag above already covers you.
  # (You only put other users or different console roles here).
  access_entries = {}
}