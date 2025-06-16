resource "aws_instance" "webserver" {
  ami                    = "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  key_name               = "Hcl-prac-training"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "Welcome to Blr" | sudo tee /var/www/html/index.html
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF

  tags = {
    Name = "myec2"
  }
}


# Security Group (Allow HTTP + SSH)
resource "aws_security_group" "web_sg" {
  name = "web-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (for demo only)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


output "public_ip" {
  value = aws_instance.webserver.public_ip
}