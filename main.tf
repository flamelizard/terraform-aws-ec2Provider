resource "aws_security_group" "sg" {
  description = "Allow HTTP & SSH"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "vm" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  # todo create new key
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.sg.id]
  root_block_device {
    volume_size = var.volume_gb
  }
  user_data = <<EOF
#!/bin/bash
set -xe
yum update
yum -y install docker
systemctl enable docker
systemctl start docker
docker pull nginx
docker run -d -p 80:80 nginx
EOF
}
