resource aws_route53_zone private {
  name = "${var.cluster_name}.${var.private_zone_parent_domain}"

  vpc {
    vpc_id = var.main_vpc
  }

  tags = local.common_tags
}

locals {
  private_dns_server_ip = cidrhost(var.main_cidr, 2)
}
