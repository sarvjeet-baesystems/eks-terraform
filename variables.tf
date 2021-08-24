variable cluster_name {
  description = "Will be used to drive naming of resources"
  validation {
    condition     = can(regex("[0-9a-z\\-]{3,}", var.cluster_name))
    error_message = "Cluster name should be lowercase alphanumeric with dashes allowed."
  }
}

variable aws_account_id {
  description = "AWS Account ID in which to create resources. This will ensure we don't create resources is wrong account"
}

variable owner {
  description = "To drive `owner` tag on resources."
}

variable region {
  default = "us-east-1"
}

variable private_zone_parent_domain {
  description = "Private domain parent for which we will create cluster (cluster_name.private_zone_parent_domain) private route53 zone attached to VPC"
  default = "package.local"
}

variable main_cidr {
  default = ""
  description = "If planing to use VPN, ensure main block as at least /18"
}

variable main_vpc {
  default = ""
  description = "ID of the VPC to deploy EKS"
}

variable vpc_subnets {
  default = ["",""]
  description = "ID of the subnets to deploy EKS"
}

variable vpc_subnet_cidrs{
  default = ["","",""] 
  description = "Subnets that are allowed access to the cluster"
}

variable private_subnets_newbits {
  default     = 2
  type        = number
  description = "Must be at least 2 bits"
}

variable public_subnets_newbits {
  default     = 6
  type        = number
  description = "Must be at least 4 bits"
}

variable vpn_client_subnets_newbits {
  default     = 4
  type        = number
  description = "Subnet bits offset used to calculate Client CIDR range for VPN endpoint (resulting block must be at least /22)"
}

variable eks_instance_type {
  description = "EKS cluster node type"
  default     = "m5.2xlarge"
}

variable root_volume_type_override {
  default = "gp2"
}

variable asg_max_size {
  description = "EKS auto-scaling-group maximum size"
  type        = number
  default     = 6
}

variable asg_min_size {
  description = "EKS auto-scaling-group minimum size"
  type        = number
  default     = 2
}

variable asg_desired_capacity {
  description = "EKS auto-scaling-group desired capacity"
  type        = number
  default     = 4
}

variable eks_version {
  description = "version of EKS cluster"
  default     = "1.20"
}

variable write_kubeconfig {
  description = "Set to false is you don't want to generate kubeconfig file for managed cluster"
  type        = bool
  default     = true
}

variable is_airgapped {
  description = "Disables internet access on the cluster"
  type        = bool
  default     = false
}

variable enable_vpn_endpoint {
  description = "If enabled VPN endpoint will be created in VPC and OpenVPN config file will be generated in the project folder"
  default = false
}
