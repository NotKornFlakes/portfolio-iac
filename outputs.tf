output "custom_domain_url" {
  description = "Public URL of the site on the custom domain"
  value       = "https://${var.domain_name}"
}

output "worker_name" {
  description = "Worker that serves the site"
  value       = cloudflare_workers_script.site.script_name
}
