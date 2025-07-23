provider "aws" {
  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "strapi" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 (Ohio)
  instance_type = "t2.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 80:1337 reshh07/strapi-ec2:latest
              EOF

  tags = {
    Name = "Strapi-Instance"
  }
}
