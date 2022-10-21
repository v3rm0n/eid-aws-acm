variable "cloudflare_api_token" {
  type = string
}

variable "subdomain" {
  type    = string
  default = "demo"
}

variable "dns_zone" {
  type    = string
  default = "maido.io"
}