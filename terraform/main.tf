provider "aws" {
  region     = "us-east-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "strapi" {
  ami           = "ami-08c40ec9ead489470" # Ubuntu 22.04 LTS (Ohio)
  instance_type = "t2.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              docker login -u ${var.dockerhub_username} -p ${var.docker_password}
              docker pull ${var.dockerhub_username}/strapi-ec2:latest
              docker run -d -p 80:1337 ${var.dockerhub_username}/strapi-ec2:latest
            EOF

  tags = {
    Name = "StrapiEC2"
  }
}
