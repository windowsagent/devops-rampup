variable "public_subnet_id" {}
variable "movie_sg_id" {}

resource "aws_instance" "movie_kubernetes_instance" {
  ami           = "ami-058bd2d568351da34"
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true
  key_name = "knox-key"

  security_groups = [var.movie_sg_id]

  tags = {
    Name = "kubernetes-instance"
  }

  user_data = file("${path.module}/provision.sh")
}

output "instance_ip" {
  description = "The public ip of the Kubernetes cluster"
  value = aws_instance.movie_kubernetes_instance.public_ip
}
