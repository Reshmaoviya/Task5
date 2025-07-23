variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key ID"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
  type        = string
}

variable "key_name" {
  description = "Name of the existing AWS key pair to use for EC2"
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "docker_password" {
  description = "Docker Hub password or access token"
  type        = string
}
