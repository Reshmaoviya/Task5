provider "aws" {
  region     = "us-east-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "strapi" {
  ami                         = "ami-0c55b159cbfafe1f0" # Use valid Ubuntu AMI for us-east-2
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo docker run -d -p 80:1337 --name strapi-container ${var.dockerhub_username}/strapi-ec2
              EOF

  tags = {
    Name = "strapi-instance"
  }
}

