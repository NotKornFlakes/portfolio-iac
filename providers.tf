terraform {
  # 1.10+ for S3 native state locking (use_lockfile)
  required_version = ">= 1.10.0"

  # Remote state in a Cloudflare R2 bucket through R2's S3-compatible API.
  # Credentials and the account endpoint come from environment variables so
  # nothing account-specific is committed:
  #   AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY  R2 token for this bucket only
  #   AWS_ENDPOINT_URL_S3                        https://<account_id>.r2.cloudflarestorage.com
  backend "s3" {
    bucket = "timfletcher-tfstate"
    key    = "portfolio.tfstate"
    region = "auto"

    # R2 isn't AWS: skip the AWS-only checks and use path-style URLs
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true

    # Lock with a .tflock object. R2 evaluates If-None-Match on writes
    # atomically, so two runs can't hold the lock at once.
    use_lockfile = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.27"
    }
  }
}

# Scoped API token: Workers Scripts on the account, plus DNS, Zone Settings
# and Transform Rules on this one zone
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
