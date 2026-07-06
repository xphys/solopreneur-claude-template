# Remote state — configure at bootstrap, before the first apply.
# Create the bucket once (versioned + encrypted), then uncomment:
#
# terraform {
#   backend "s3" {
#     bucket       = "{{PLATFORM_SLUG}}-tfstate"
#     key          = "envs/prod/terraform.tfstate"
#     region       = "{{AWS_REGION}}"
#     profile      = "{{AWS_PROFILE}}"
#     use_lockfile = true
#   }
# }
