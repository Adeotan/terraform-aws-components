provider "aws" {
  # The AWS provider to use to make changes in the DNS primary account
  alias  = "primary"
  region = var.region

  # Profile is deprecated in favor of terraform_role_arn. When profiles are not in use, terraform_profile_name is null.
  profile = module.iam_roles.dns_terraform_profile_name

  dynamic "assume_role" {
    # module.iam_roles.dns_terraform_role_arn may be null, in which case do not assume a role.
    for_each = compact([module.iam_roles.dns_terraform_role_arn])
    content {
      role_arn = assume_role.value
    }
  }
}