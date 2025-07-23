resource "aws_instance" "strapi" {
  ami                    = "ami-0c55b159cbfafe1f0"  # ✅ Replace this with the correct one
  instance_type          = "t2.micro"
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io -y
              sudo systemctl start docker
              sudo docker run -d -p 80:1337 ${var.dockerhub_username}/strapi-ec2
              EOF

  tags = {
    Name = "StrapiEC2"
  }
}
