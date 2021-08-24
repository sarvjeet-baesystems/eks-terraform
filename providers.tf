terraform {
  required_version = ">= 0.14.0"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.2.0"
    }
  }
}

# TODO: remove in next version
provider aws {
  alias  = "root"
  region = var.region
}

# main account for resources
provider aws {
  region              = var.region
  max_retries         = 20
  allowed_account_ids = [var.aws_account_id]
}

# to configure AWS AUTH config map
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}