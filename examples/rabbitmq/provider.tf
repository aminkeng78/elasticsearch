
provider "aws" {
  region  = "us-west-1"
  profile = "default"

  default_tags {
    tags = local.mandatory_tag
  }
}