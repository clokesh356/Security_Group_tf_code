resource "aws_security_group" "bastion" {
  name        = "bastion_sg"
  description = "Allow admin through ssh"
  vpc_id      = "vpc-03a5eff0afffbbce9"

  ingress {
    description = "admin ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["27.59.254.25/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_security_group" "apache" {
  name        = "apache_sg"
  description = "Allow apache through http"
  vpc_id      = "vpc-03a5eff0afffbbce9"

  ingress {
    description     = "admin ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  ingress {
    description = "enduser http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "apache_sg"
  }
}

