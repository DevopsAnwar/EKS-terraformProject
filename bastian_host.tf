resource "aws_security_group" "bastion-allow-ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "bastion-allow-ssh"
  description = "security group for bastion that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-allow-ssh"
  }
}

resource "aws_security_group" "private-ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "private-ssh"
  description = "security group for private that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ aws_security_group.bastion-allow-ssh.id ]
  }
  tags = {
    Name = "private-ssh"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t3.large"
  subnet_id = aws_subnet.public-us-east-1a.id
  vpc_security_group_ids = [aws_security_group.bastion-allow-ssh.id]

  key_name = "local"
}

resource "aws_instance" "private" {
  ami           = "ami-0a75bd84854bc95c9"
  instance_type = "t3.large"
  subnet_id = aws_subnet.private-us-east-1b.id
  vpc_security_group_ids = [aws_security_group.private-ssh.id]
  key_name = "local"
}

