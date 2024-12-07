provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "syg"
  region = "ap-southeast-1"
}

data "aws_ami" "amazon-linux-3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "myinstance_mumbai" {
  ami           = data.aws_ami.amazon-linux-3.id
  instance_type = "t2.micro"
  count         = 1
  tags = {
    Name = "myinstance_mumbai"
  }
}

resource "aws_instance" "myinstance_singapore" {
  ami           = "ami-059b01eb1dee1e15c"
  instance_type = "t2.micro"
  count         = 1
  provider      = aws.syg
  tags = {
    Name = "myinstance_singapore"
  }
}