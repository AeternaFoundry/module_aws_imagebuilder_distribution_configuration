output "imagebuilder_distribution_configurations_id" {
  description = "Map of id values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.id if v.id != null && length(v.id) > 0 }
}
output "imagebuilder_distribution_configurations_arn" {
  description = "Map of arn values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "imagebuilder_distribution_configurations_date_created" {
  description = "Map of date_created values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.date_created if v.date_created != null && length(v.date_created) > 0 }
}
output "imagebuilder_distribution_configurations_date_updated" {
  description = "Map of date_updated values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.date_updated if v.date_updated != null && length(v.date_updated) > 0 }
}
output "imagebuilder_distribution_configurations_description" {
  description = "Map of description values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.description if v.description != null && length(v.description) > 0 }
}
output "imagebuilder_distribution_configurations_distribution" {
  description = "Map of distribution values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.distribution if v.distribution != null && length(v.distribution) > 0 }
}
output "imagebuilder_distribution_configurations_name" {
  description = "Map of name values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.name if v.name != null && length(v.name) > 0 }
}
output "imagebuilder_distribution_configurations_region" {
  description = "Map of region values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.region if v.region != null && length(v.region) > 0 }
}
output "imagebuilder_distribution_configurations_tags" {
  description = "Map of tags values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "imagebuilder_distribution_configurations_tags_all" {
  description = "Map of tags_all values across all imagebuilder_distribution_configurations, keyed the same as var.imagebuilder_distribution_configurations"
  value       = { for k, v in aws_imagebuilder_distribution_configuration.imagebuilder_distribution_configurations : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

