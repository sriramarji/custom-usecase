/*resource "aws_instance" "webserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt update -y
  #   sudo apt install nginx -y
  #   echo "Welcome to HCLTech" | sudo tee /var/www/html/index.html
  #   sudo systemctl enable nginx
  #   sudo systemctl start nginx
  # EOF

  tags = {
    Name = "custom-ec2"
  }
}*/

resource "aws_instance" "webserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  cat <<EOL > /var/www/html/index.html
  <!DOCTYPE html>
  <html>
  <head>
    <title>Welcome to HCLTech</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body class="container text-center mt-5">
    <h1 class="display-4">Welcome to HCLTech</h1>
    <p class="lead">Currently Undergoing DevOps Training.</p>
    <p class="lead">This is a styled page served from Apache.</p>
  </body>
  </html>
  EOL
  sudo systemctl enable apache2
  sudo systemctl start apache2
EOF

  tags = {
    Name = var.name
  }
}


# Security Group (Allow HTTP + SSH)
resource "aws_security_group" "web_sg" {
  name = "custom-sg"
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