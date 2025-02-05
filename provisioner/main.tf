provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "server1" {
  ami           = "ami-04681163a08179f28"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  depends_on    = [local_file.key1 ]

}

resource "null_resource" "provisioner" {

  provisioner "local-exec" {
    command = "echo ${aws_instance.server1.public_ip} > ip_address.txt"
  }

  provisioner "file" {
    source      = "ip_address.txt"
    destination = "/home/ec2-user/ip_address.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = local_file.key1.filename
    host        = aws_instance.server1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chmod -R 666 /var/www/html",
      "sudo echo '<h1>Welcome to Terraform</h1>' |sudo  tee  /var/www/html/index.html"
    ]
  }

  depends_on = [aws_instance.server1, local_file.key1]

}


/*
1- what is terraform?
2- why terraform?
3- building blocks of terraform
    a- provider 
    b- resource
    c- data source
    d- variable
    e- output
    f- module
    g- provisioner
    h- import
    i- terraform commands
    j-   a- terraform init
         b- terraform plan
         c- terraform apply
         d- terraform destroy
         e- terraform validate
         f- terraform fmt
         g- terraform show
         h- terraform state
         i- terraform import
         j- terraform workspace
4- state file management
5- modules
6- different environments
7- sensitive data
6- best practices
    a- use modules
    b- use version control
    c- use remote state
    d- use workspaces // workspace 
   
*/

