locals {
  domain_name  = "${var.subdomain}.${var.dns_zone}"
  certificates = fileset(path.module, "cert/*.crt")
  truststore   = join("\n", [for f in local.certificates : file(f)])
}

data "cloudflare_zone" "zone" {
  name = var.dns_zone
}