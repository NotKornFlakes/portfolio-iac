# TLS settings for the zone, one resource per setting
locals {
  # Full (strict): Cloudflare only connects to origins with a valid
  # certificate. The Worker is the origin today, so this guards any origin
  # added later. always_use_https redirects http:// to https://.
  tls_settings = {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    automatic_https_rewrites = "on"
  }
}

resource "cloudflare_zone_setting" "tls" {
  for_each = local.tls_settings

  zone_id    = var.cloudflare_zone_id
  setting_id = each.key
  value      = each.value
}

# HSTS: browsers only ever connect over HTTPS for the next year.
# nosniff sends X-Content-Type-Options: nosniff.
resource "cloudflare_zone_setting" "security_header" {
  zone_id    = var.cloudflare_zone_id
  setting_id = "security_header"
  value = {
    strict_transport_security = {
      enabled            = true
      max_age            = 31536000
      include_subdomains = true
      preload            = false
      nosniff            = true
    }
  }
}
