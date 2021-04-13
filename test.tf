provider "aws" {
  region = "us-east-2"
  access_key = "xxxxxxxxxxxxxxxxxx"
  secret_key = "yyyyyyyyyyyyyyyyyyyyyy"
}

resource "aws_instance" "example" {
  ami           = " ami-01e7ca2ef94a0ae86"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              yes | sudo get-apt install ansible
              yes | sudo get-apt install git 
              EOF
  
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {

    name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml" 
}
}
