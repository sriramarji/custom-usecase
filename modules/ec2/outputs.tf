output "public_ip" {
  value = aws_instance.webserver.public_ip
}

output "ec2_instance_tags" {
  value = aws_instance.webserver.tags_all
}