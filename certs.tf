module vpn_certs {
  count = var.enable_vpn_endpoint ? 1 : 0

  source         = "./modules/tls-certs"
  owner          = "eks-${var.cluster_name}"
  ca_common_name = "eks-${var.cluster_name}-ca"

  server_common_name = "${var.cluster_name}.${var.private_zone_parent_domain}"
  client_dns_names   = ["client.${var.cluster_name}.${var.private_zone_parent_domain}"]
  server_dns_names   = ["server.${var.cluster_name}.${var.private_zone_parent_domain}"]

  # webserver certs
  web_common_name = aws_route53_zone.private.name
  web_dns_domains = [
    # wildcard should be good for the most part
    "*.${aws_route53_zone.private.name}"
  ]
}

resource local_file root_ca_cert {
  count = var.enable_vpn_endpoint ? 1 : 0
  filename = "${path.root}/certs/rootCA.pem"
  content  = module.vpn_certs.0.ca_cert_pem
}

resource local_file web_cert {
  count = var.enable_vpn_endpoint ? 1 : 0
  filename = "${path.root}/certs/tls-crt.pem"
  content  = module.vpn_certs.0.web_cert_pem
}

resource local_file web_key {
  count = var.enable_vpn_endpoint ? 1 : 0
  filename = "${path.root}/certs/tls-key.pem"
  content  = module.vpn_certs.0.web_key_pem
}
