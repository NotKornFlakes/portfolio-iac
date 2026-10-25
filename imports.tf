# Adopt the Cloudflare resources that existed before the move to R2 state.
# Once a resource is in state its import block is a no-op, so these stay as a
# record of the original IDs and can rebuild the state if it's ever lost
# (R2 has no object versioning).

import {
  to = cloudflare_dns_record.null_mx
  id = "${var.cloudflare_zone_id}/1c76bec0dc893995b4bca04e3c3a5c56"
}

import {
  to = cloudflare_dns_record.spf
  id = "${var.cloudflare_zone_id}/9fc7a0b44010adae2e55d9ff69b1f8f5"
}

import {
  to = cloudflare_dns_record.dmarc
  id = "${var.cloudflare_zone_id}/3ae09092499ba506e9558df8b7145b2b"
}

import {
  to = cloudflare_dns_record.dkim_null
  id = "${var.cloudflare_zone_id}/8325bc097b0c04611576963ab98041d4"
}

import {
  for_each = local.tls_settings
  to       = cloudflare_zone_setting.tls[each.key]
  id       = "${var.cloudflare_zone_id}/${each.key}"
}

import {
  to = cloudflare_zone_setting.security_header
  id = "${var.cloudflare_zone_id}/security_header"
}

import {
  to = cloudflare_ruleset.security_headers
  id = "zones/${var.cloudflare_zone_id}/47ae9011951640f0869d4d4807e798a7"
}

import {
  to = cloudflare_zone_dnssec.site
  id = var.cloudflare_zone_id
}
