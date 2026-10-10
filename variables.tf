variable "imagebuilder_distribution_configurations" {
  description = <<EOT
Map of imagebuilder_distribution_configurations, attributes below
Required:
    - name
    - distribution (block):
        - ami_distribution_configuration (optional, block):
            - ami_tags (optional)
            - description (optional)
            - kms_key_id (optional)
            - launch_permission (optional, block):
                - organization_arns (optional)
                - organizational_unit_arns (optional)
                - user_groups (optional)
                - user_ids (optional)
            - name (optional)
            - target_account_ids (optional)
        - container_distribution_configuration (optional, block):
            - container_tags (optional)
            - description (optional)
            - target_repository (required, block):
                - repository_name (required)
                - service (required)
        - fast_launch_configuration (optional, block):
            - account_id (required)
            - enabled (required)
            - launch_template (optional, block):
                - launch_template_id (optional)
                - launch_template_name (optional)
                - launch_template_version (optional)
            - max_parallel_launches (optional)
            - snapshot_configuration (optional, block):
                - target_resource_count (optional)
        - launch_template_configuration (optional, block):
            - account_id (optional)
            - default (optional)
            - launch_template_id (required)
        - license_configuration_arns (optional)
        - region (required)
        - s3_export_configuration (optional, block):
            - disk_image_format (required)
            - role_name (required)
            - s3_bucket (required)
            - s3_prefix (optional)
        - ssm_parameter_configuration (optional, block):
            - ami_account_id (optional)
            - data_type (optional)
            - parameter_name (required)
Optional:
    - description
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    name        = string
    description = optional(string)
    region      = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    distribution = list(object({
      ami_distribution_configuration = optional(object({
        ami_tags    = optional(map(string))
        description = optional(string)
        kms_key_id  = optional(string)
        launch_permission = optional(object({
          organization_arns        = optional(set(string))
          organizational_unit_arns = optional(set(string))
          user_groups              = optional(set(string))
          user_ids                 = optional(set(string))
        }))
        name               = optional(string)
        target_account_ids = optional(set(string))
      }))
      container_distribution_configuration = optional(object({
        container_tags = optional(set(string))
        description    = optional(string)
        target_repository = object({
          repository_name = string
          service         = string
        })
      }))
      fast_launch_configuration = optional(list(object({
        account_id = string
        enabled    = bool
        launch_template = optional(object({
          launch_template_id      = optional(string)
          launch_template_name    = optional(string)
          launch_template_version = optional(string)
        }))
        max_parallel_launches = optional(number)
        snapshot_configuration = optional(object({
          target_resource_count = optional(number)
        }))
      })))
      launch_template_configuration = optional(list(object({
        account_id         = optional(string)
        default            = optional(bool)
        launch_template_id = string
      })))
      license_configuration_arns = optional(set(string))
      region                     = string
      s3_export_configuration = optional(object({
        disk_image_format = string
        role_name         = string
        s3_bucket         = string
        s3_prefix         = optional(string)
      }))
      ssm_parameter_configuration = optional(list(object({
        ami_account_id = optional(string)
        data_type      = optional(string)
        parameter_name = string
      })))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        length(v.distribution) >= 1
      )
    ])
    error_message = "Each distribution list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.fast_launch_configuration == null || (length(item.fast_launch_configuration) <= 1000))])
      )
    ])
    error_message = "Each fast_launch_configuration list must contain at most 1000 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.launch_template_configuration == null || (length(item.launch_template_configuration) <= 100))])
      )
    ])
    error_message = "Each launch_template_configuration list must contain at most 100 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.ami_distribution_configuration == null || (item.ami_distribution_configuration.launch_permission == null || (item.ami_distribution_configuration.launch_permission.user_groups == null || (alltrue([for x in item.ami_distribution_configuration.launch_permission.user_groups : length(x) >= 1 && length(x) <= 1024])))))])
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.container_distribution_configuration == null || (item.container_distribution_configuration.container_tags == null || (alltrue([for x in item.container_distribution_configuration.container_tags : length(x) >= 1 && length(x) <= 1024]))))])
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.container_distribution_configuration == null || (contains(["ECR"], item.container_distribution_configuration.target_repository.service)))])
      )
    ])
    error_message = "must be one of: ECR"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.fast_launch_configuration == null || alltrue([for item in item.fast_launch_configuration : (item.max_parallel_launches == null || (item.max_parallel_launches >= 1 && item.max_parallel_launches <= 10000))]))])
      )
    ])
    error_message = "must be between 1 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.fast_launch_configuration == null || alltrue([for item in item.fast_launch_configuration : (item.snapshot_configuration == null || (item.snapshot_configuration.target_resource_count == null || (item.snapshot_configuration.target_resource_count >= 1 && item.snapshot_configuration.target_resource_count <= 10000)))]))])
      )
    ])
    error_message = "must be between 1 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.launch_template_configuration == null || alltrue([for item in item.launch_template_configuration : (length(item.launch_template_id) >= 1)]))])
      )
    ])
    error_message = "[from verify.ValidLaunchTemplateID: invalid when len(value) < 1]"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.launch_template_configuration == null || alltrue([for item in item.launch_template_configuration : (length(item.launch_template_id) <= 255)]))])
      )
    ])
    error_message = "[from verify.ValidLaunchTemplateID: invalid when len(value) > 255]"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.s3_export_configuration == null || (length(item.s3_export_configuration.role_name) >= 1 && length(item.s3_export_configuration.role_name) <= 1024))])
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.s3_export_configuration == null || (item.s3_export_configuration.s3_prefix == null || (length(item.s3_export_configuration.s3_prefix) >= 1 && length(item.s3_export_configuration.s3_prefix) <= 1024)))])
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.imagebuilder_distribution_configurations : (
        alltrue([for item in v.distribution : (item.ssm_parameter_configuration == null || alltrue([for item in item.ssm_parameter_configuration : (length(item.parameter_name) >= 1 && length(item.parameter_name) <= 1011)]))])
      )
    ])
    error_message = "must be between 1 and 1011 characters"
  }
  # Note: 28 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

