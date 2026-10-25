variable "project_name" {
  description = "Name of the Worker that serves the site (lowercase letters and numbers only)"
  type        = string
  default     = "portfolio"

  validation {
    condition     = can(regex("^[a-z0-9]{3,12}$", var.project_name))
    error_message = "project_name must be 3-12 lowercase letters or numbers."
  }
}

variable "domain_name" {
  description = "Custom domain for the site (must already be a zone in Cloudflare)"
  type        = string
  default     = "timfletcher.tech"
}

variable "cloudflare_account_id" {
  description = "Account ID from the Cloudflare dashboard (Overview page of the zone, right sidebar)"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID from the Cloudflare dashboard (Overview page, right sidebar)"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token scoped to this account's Workers and this zone"
  type        = string
  sensitive   = true
}
