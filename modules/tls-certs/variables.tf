# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable owner {
  description = "The OS user who should be given ownership over the certificate files."
  default = "bluescape"
}

variable organization_name {
  description = "The name of the organization to associate with the certificates (e.g. Acme Co)."
  default = "bluescape"
}

variable ca_common_name {
  description = "The common name to use in the subject of the CA certificate (e.g. acme.co cert)."
  default = "bluescape"
}

variable server_common_name {
  description = "The common name to use in the subject of the certificate (e.g. acme.co cert)."
  default = "vpn.server"
}

variable server_dns_names {
  description = "List of DNS names for which the certificate will be valid (e.g. vault.service.consul, foo.example.com)."
  type        = list(string)
  default = ["vpn.server.local"]
}

variable client_common_name {
  description = "The common name to use in the subject of the certificate (e.g. acme.co cert)."
  default = "vpn.client"
}

variable client_dns_names {
  description = "List of DNS names for which the certificate will be valid (e.g. vault.service.consul, foo.example.com)."
  type        = list(string)
  default = ["vpn.client.local"]
}

variable validity_period_hours {
  description = "The number of hours after initial issuing that the certificate will become invalid. Default 1 year"
  default = "8760"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable ca_allowed_uses {
  description = "List of keywords from RFC5280 describing a use that is permitted for the CA certificate. For more info and the list of keywords, see https://www.terraform.io/docs/providers/tls/r/self_signed_cert.html#allowed_uses."
  type        = list(string)

  default = [
    "cert_signing",
    "key_encipherment",
    "digital_signature",
  ]
}

variable allowed_uses {
  description = "List of keywords from RFC5280 describing a use that is permitted for the issued certificate. For more info and the list of keywords, see https://www.terraform.io/docs/providers/tls/r/self_signed_cert.html#allowed_uses."
  type        = list(string)

  default = [
    "key_encipherment",
    "digital_signature",
  ]
}

variable private_key_algorithm {
  description = "The name of the algorithm to use for private keys. Must be one of: RSA or ECDSA."
  default     = "RSA"
}

variable private_key_ecdsa_curve {
  description = "The name of the elliptic curve to use. Should only be used if var.private_key_algorithm is ECDSA. Must be one of P224, P256, P384 or P521."
  default     = "P256"
}

variable private_key_rsa_bits {
  description = "The size of the generated RSA key in bits. Should only be used if var.private_key_algorithm is RSA."
  default     = "2048"
}

variable web_common_name {

}

variable web_dns_domains {
  type = list(string)
  default = []
}