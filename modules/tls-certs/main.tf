# ---------------------------------------------------------------------------------------------------------------------
#  CREATE A CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

resource tls_private_key ca {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource tls_self_signed_cert ca {
  key_algorithm     = tls_private_key.ca.algorithm
  private_key_pem   = tls_private_key.ca.private_key_pem
  is_ca_certificate = true

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.ca_allowed_uses

  subject {
    common_name  = var.ca_common_name
    organization = var.organization_name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE SERVER TLS CERTIFICATE SIGNED USING THE CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

resource tls_private_key server {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource tls_cert_request server {
  key_algorithm   = tls_private_key.server.algorithm
  private_key_pem = tls_private_key.server.private_key_pem

  dns_names = var.server_dns_names

  subject {
    common_name  = var.server_common_name
    organization = var.organization_name
  }
}

resource tls_locally_signed_cert server {
  cert_request_pem = tls_cert_request.server.cert_request_pem

  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.allowed_uses
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE CLIENT TLS CERTIFICATE SIGNED USING THE CA CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

resource tls_private_key client {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource tls_cert_request client {
  key_algorithm   = tls_private_key.client.algorithm
  private_key_pem = tls_private_key.client.private_key_pem

  dns_names = var.server_dns_names

  subject {
    common_name  = var.server_common_name
    organization = var.organization_name
  }
}

resource tls_locally_signed_cert client {
  cert_request_pem = tls_cert_request.client.cert_request_pem

  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.allowed_uses
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE WEB CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------

resource tls_private_key web {
  algorithm   = var.private_key_algorithm
  ecdsa_curve = var.private_key_ecdsa_curve
  rsa_bits    = var.private_key_rsa_bits
}

resource tls_cert_request web {
  key_algorithm   = tls_private_key.web.algorithm
  private_key_pem = tls_private_key.web.private_key_pem

  dns_names = var.web_dns_domains

  subject {
    common_name  = var.web_common_name
    organization = var.organization_name
  }
}

resource tls_locally_signed_cert web {
  cert_request_pem = tls_cert_request.web.cert_request_pem

  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = var.validity_period_hours
  allowed_uses          = var.allowed_uses
}
