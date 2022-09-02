
locals {
  mandatory_tag = {
    project        = "SHI-Morphues"
    application    = ""
    builder        = "SHI"
    Ower           = "CONILIUS"
    Group          = "DCS-IAC"
    component_name = "Morphues-HA"
  }
  vpc_id          = data.aws_vpc.vpc_id.id
  subnet_ids      = data.aws_subnet_ids.all.ids
 
}

  resource "aws_security_group" "shi_mqSg" {
    description = "shi_mqSq"
  vpc_id      = local.vpc_id

  ingress {
       from_port    = 61617
        to_port     = 61617
        protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
lifecycle {
    create_before_destroy = true
  }

}
  
data "aws_vpc" "vpc_id" {
  id = var.vpc_id
}

data "aws_subnet_ids" "all" {
vpc_id = data.aws_vpc.vpc_id.id

  filter {
    name = "tag:Name"
    values = ["default_*"]
  }
  }

  data "aws_subnet" "cidrs" {
    for_each = data.aws_subnet_ids.all.ids
     id = each.value
  }

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
