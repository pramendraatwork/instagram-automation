provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "n8n_key" {
  key_name   = "instagram-automation-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "n8n_sg" {
  name        = "n8n-security-group-v2"
  description = "Security group for n8n server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5678
    to_port     = 5678
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

resource "aws_instance" "n8n_server" {
  ami                         = "ami-0f58b397bc5c1f2e8"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.n8n_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.n8n_sg.id]

  tags = {
    Name = "instagram-automation"
  }
}

output "public_ip" {
  value = aws_instance.n8n_server.public_ip
}
