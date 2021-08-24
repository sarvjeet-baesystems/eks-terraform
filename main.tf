locals {
  common_tags = {
    environment = var.cluster_name
    cluster     = var.cluster_name
    owner       = var.owner
  }
}

# to find available zones
data aws_availability_zones available {
}

# to configure aws auth
data aws_eks_cluster cluster {
  name = module.eks.cluster_id
}

# to configure aws auth
data aws_eks_cluster_auth cluster {
  name = module.eks.cluster_id
}

## worker group security to control internet and endpoints access
resource aws_security_group workers {
  name_prefix = "eks-${var.cluster_name}-workers"
  description = "eks-${var.cluster_name}-workers"

  vpc_id = var.main_vpc
  tags   = local.common_tags
}

resource aws_security_group_rule workers_vpc_in {
  description       = "Allow other resources on VPC to talk to workers"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.workers.id
  cidr_blocks       = [var.main_cidr]
  type              = "ingress"
}

resource aws_security_group_rule workers_vpc_out {
  description       = "To access other resources on VPC"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.workers.id
  cidr_blocks       = [var.main_cidr]
  type              = "egress"
}

resource aws_security_group_rule workers_s3_out {
  description       = "To access S3 for pulling images"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.workers.id
  prefix_list_ids   = ["pl-e0b05589"]
  type              = "egress"
}

# internet access allowed only if var.is_airgapped is not enabled
resource aws_security_group_rule workers_internet_out {
  description       = "To allow all outbound connection to the internet"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.workers.id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}

module eks {
  source          = "terraform-aws-modules/eks/aws"
  version         = "16.2.0"
  cluster_name    = var.cluster_name
  cluster_version = var.eks_version
  manage_aws_auth = true

  # kubeconfig filename with creds to access cluster api
  write_kubeconfig = var.write_kubeconfig

  worker_create_security_group = false
  worker_security_group_id     = aws_security_group.workers.id

  cluster_endpoint_private_access                = true
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_cidrs          = var.vpc_subnet_cidrs 

  tags = local.common_tags

  vpc_id  = var.main_vpc
  subnets = var.vpc_subnets

  worker_groups_launch_template = [
    # private group
    {
      instance_type        = var.eks_instance_type
      asg_max_size         = var.asg_max_size
      asg_min_size         = var.asg_min_size
      asg_desired_capacity = var.asg_desired_capacity
      root_volume_type     = var.root_volume_type_override
      subnets              = var.vpc_subnets
    },
  ]
}
