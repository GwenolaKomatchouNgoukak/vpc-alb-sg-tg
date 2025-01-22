terraform {
  backend "s3" {
    bucket = "week6-kng-terraform-bucket"
    key    = "vpc-alb-sg-tg/terraform.tfstate"
    region = "eu-west-3"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}