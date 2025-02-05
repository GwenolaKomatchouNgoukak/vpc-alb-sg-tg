provider "aws" {
  region = "us-east-1"
}

import {
  to = aws_instance.web
  id = "i-00c9820754d6a0c56"
}

resource "aws_instance" "web" {
  ami                                  = "ami-0c614dee691cbbf37"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1c"
  instance_type                        = "t2.micro"
  key_name                             = "lamp_key_pair"
  monitoring                           = false
  subnet_id                            = "subnet-0a6303454a20c3540"
  vpc_security_group_ids      = ["sg-0c5d0307af3f9fa1f"]
  tags = {
    Name = "terraform_server"
  } 
}