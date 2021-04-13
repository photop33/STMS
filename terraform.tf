provider "aws" {
  region = "us-east-2"
  access_key = "XXXXXXXXXXXXXXXXXXXXX"
  secret_key = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
}

resource "aws_instance" "example" {
  ami           = "ami-01e7ca2ef94a0ae86"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
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
}
# Add Output
output "public_ip" {
  value       = "aws_instance.example.public_ip"
  description = "The public IP of the web server"
}
}
resource "aws_instance" "web" {
  # ...
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "fedora"
      private_key = "${file(var.ssh_key_private)}"
    }
module "my_git_repo" {
  source = "https://github.com/photop33/STMS.git"
}
  provisioner "local-exec" {
    command = "ansible-playbook -u fedora -i '${self.public_ip},' --private-key ${var.ssh_key_private} pkg_nginx.yml" 
  }
}
