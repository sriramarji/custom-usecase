module "ec2" {
  source = "./modules/ec2"

  ami_id        = var.my-amiid
  instance_type = var.my-instance_type
  key_name      = var.my-keyname
}