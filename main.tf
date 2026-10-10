resource "aws_imagebuilder_distribution_configuration" "imagebuilder_distribution_configurations" {
  for_each = var.imagebuilder_distribution_configurations

  name        = each.value.name
  description = each.value.description
  region      = each.value.region
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  dynamic "distribution" {
    for_each = each.value.distribution
    content {
      dynamic "ami_distribution_configuration" {
        for_each = distribution.value.ami_distribution_configuration != null ? [distribution.value.ami_distribution_configuration] : []
        content {
          ami_tags    = ami_distribution_configuration.value.ami_tags
          description = ami_distribution_configuration.value.description
          kms_key_id  = ami_distribution_configuration.value.kms_key_id
          dynamic "launch_permission" {
            for_each = ami_distribution_configuration.value.launch_permission != null ? [ami_distribution_configuration.value.launch_permission] : []
            content {
              organization_arns        = launch_permission.value.organization_arns
              organizational_unit_arns = launch_permission.value.organizational_unit_arns
              user_groups              = launch_permission.value.user_groups
              user_ids                 = launch_permission.value.user_ids
            }
          }
          name               = ami_distribution_configuration.value.name
          target_account_ids = ami_distribution_configuration.value.target_account_ids
        }
      }
      dynamic "container_distribution_configuration" {
        for_each = distribution.value.container_distribution_configuration != null ? [distribution.value.container_distribution_configuration] : []
        content {
          container_tags = container_distribution_configuration.value.container_tags
          description    = container_distribution_configuration.value.description
          target_repository {
            repository_name = container_distribution_configuration.value.target_repository.repository_name
            service         = container_distribution_configuration.value.target_repository.service
          }
        }
      }
      dynamic "fast_launch_configuration" {
        for_each = distribution.value.fast_launch_configuration != null ? distribution.value.fast_launch_configuration : []
        content {
          account_id = fast_launch_configuration.value.account_id
          enabled    = fast_launch_configuration.value.enabled
          dynamic "launch_template" {
            for_each = fast_launch_configuration.value.launch_template != null ? [fast_launch_configuration.value.launch_template] : []
            content {
              launch_template_id      = launch_template.value.launch_template_id
              launch_template_name    = launch_template.value.launch_template_name
              launch_template_version = launch_template.value.launch_template_version
            }
          }
          max_parallel_launches = fast_launch_configuration.value.max_parallel_launches
          dynamic "snapshot_configuration" {
            for_each = fast_launch_configuration.value.snapshot_configuration != null ? [fast_launch_configuration.value.snapshot_configuration] : []
            content {
              target_resource_count = snapshot_configuration.value.target_resource_count
            }
          }
        }
      }
      dynamic "launch_template_configuration" {
        for_each = distribution.value.launch_template_configuration != null ? distribution.value.launch_template_configuration : []
        content {
          account_id         = launch_template_configuration.value.account_id
          default            = launch_template_configuration.value.default
          launch_template_id = launch_template_configuration.value.launch_template_id
        }
      }
      license_configuration_arns = distribution.value.license_configuration_arns
      region                     = distribution.value.region
      dynamic "s3_export_configuration" {
        for_each = distribution.value.s3_export_configuration != null ? [distribution.value.s3_export_configuration] : []
        content {
          disk_image_format = s3_export_configuration.value.disk_image_format
          role_name         = s3_export_configuration.value.role_name
          s3_bucket         = s3_export_configuration.value.s3_bucket
          s3_prefix         = s3_export_configuration.value.s3_prefix
        }
      }
      dynamic "ssm_parameter_configuration" {
        for_each = distribution.value.ssm_parameter_configuration != null ? distribution.value.ssm_parameter_configuration : []
        content {
          ami_account_id = ssm_parameter_configuration.value.ami_account_id
          data_type      = ssm_parameter_configuration.value.data_type
          parameter_name = ssm_parameter_configuration.value.parameter_name
        }
      }
    }
  }
}

