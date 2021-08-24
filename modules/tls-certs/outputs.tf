output ca_cert_pem {
  value = tls_self_signed_cert.ca.cert_pem
}

output ca_key_pem {
  value     = tls_private_key.ca.private_key_pem
  sensitive = true
}

output client_cert_pem {
  value = tls_locally_signed_cert.client.cert_pem
}

output client_key_pem {
  value     = tls_private_key.client.private_key_pem
  sensitive = true
}

output server_cert_pem {
  value = tls_locally_signed_cert.server.cert_pem
}

output server_key_pem {
  value     = tls_private_key.server.private_key_pem
  sensitive = true
}

output web_cert_pem {
  value = tls_locally_signed_cert.web.cert_pem
}

output web_key_pem {
  value     = tls_private_key.web.private_key_pem
  sensitive = true
}
