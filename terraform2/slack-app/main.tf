variable "aws_region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region          = var.aws_region
}