
<!-- markdownlint-disable -->
# terraform-aws-mq-broker [
<!-- markdownlint-restore -->

Terraform module to provision AmazonMQ resources on AWS

## Usage


```hcl
module "mq_broker" {
  source = "../../"

  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  deployment_mode            = var.deployment_mode
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  publicly_accessible        = var.publicly_accessible
  general_log_enabled        = var.general_log_enabled
  audit_log_enabled          = var.audit_log_enabled
  kms_ssm_key_arn            = var.kms_ssm_key_arn
 # encryption_enabled        = var.encryption_enabled
  kms_mq_key_arn             = var.kms_mq_key_arn
  use_aws_owned_key          = var.use_aws_owned_key
  security_groups           = [aws_security_group.shi_mqSg.id]
  subnet_ids                = local.subnet_ids
}
```
