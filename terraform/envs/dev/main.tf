module "vpc" {
  source = "../../modules/vpc"

  name                 = "eks-platform-dev"
  cidr_block           = "10.0.0.0/16"
  azs                  = ["eu-west-2a", "eu-west-2b"]
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.16.0/20", "10.0.32.0/20"]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name        = "eks-platform-dev"
  subnet_ids          = module.vpc.private_subnet_ids
  public_access_cidrs = [var.admin_cidr]
}