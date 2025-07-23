provider "aws" {
  region     = "us-east-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

variable "key_name" {}
variable "dockerhub_username" {}
variable "docker_password" {}

resource "aws_instance" "strapi" {
  ami                    = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (Ohio) - adjust if needed
  instance_type          = "t2.micro"
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              docker login -u ${var.dockerhub_username} -p ${var.docker_password}
              docker pull reshh07/strapi-ec2:latest
              docker run -d -p 80:1337 reshh07/strapi-ec2:latest
              EOF

  tags = {
    Name = "StrapiEC2"
  }
}

output "strapi_public_ip" {
  value = aws_instance.strapi.public_ip
}
