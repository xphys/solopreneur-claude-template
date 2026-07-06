provider "aws" {
  region  = "{{AWS_REGION}}"
  profile = "{{AWS_PROFILE}}"

  default_tags {
    tags = {
      Platform  = "{{PLATFORM_SLUG}}"
      Env       = "prod"
      ManagedBy = "terraform"
    }
  }
}
