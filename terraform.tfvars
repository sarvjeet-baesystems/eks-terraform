# that this to something that will identify cluster
# SPECIFY THESE 2 VARIABLES:
cluster_name = ""
# account for resources
aws_account_id = ""

# =========== CLUSTER OPTIONS
# EKS cluster version
eks_version = "1.19"

# region for resources
region = ""

# airgap flag to disable internet access on worker nodes
is_airgapped = true

# you can change parent private domain
# instance domain zone will be combination of 2 variables 'cluster_name.private_zone_parent_domain'
private_zone_parent_domain = ""

# =========== CLUSTER SIZE
# single worker group configuration
eks_instance_type         = "m5.xlarge"
# when changing size of the cluster, volume type might require adjustments
root_volume_type_override = "gp2"

# single autoscaling group sizing
asg_max_size         = 9
asg_min_size         = 0
asg_desired_capacity = 6

# =========== VPN
# when enabled, VPN endpoint will be added and OVPN file will created in the project folder
enable_vpn_endpoint = false

# =========== VPC
# as we are not peering these clusters with other networks, there should be no need to change that
main_vpc = ""
main_cidr = ""
vpc_subnets = ["",""]
vpc_subnet_cidrs = ["","",""]


# =========== TAGS
# this is for cost tracking (don't need to change)
owner = ""
