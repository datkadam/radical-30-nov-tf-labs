provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0912f71e06545ad88" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  key_name      = "" # Replace with your SSH key name

  tags = {
    Name = "LocalExecDemo"
  }

  provisioner "local-exec" {
        command = "ping ${self.public_ip}"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}