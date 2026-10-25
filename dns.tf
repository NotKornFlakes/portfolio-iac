# DNS for the zone. The site's own records (apex and www) are created by the
# Workers custom domains in main.tf; the email records live in email.tf.

# DNSSEC signs DNS answers so resolvers can detect forged records. Cloudflare
# is also the registrar, so it publishes the DS record at the .tech registry.
# Never remove this resource while the DS record exists, or the domain stops
# resolving; disable DNSSEC in the dashboard first and wait for the DS to clear.
resource "cloudflare_zone_dnssec" "site" {
  zone_id = var.cloudflare_zone_id
  status  = "active"

  lifecycle {
    prevent_destroy = true
  }
}
