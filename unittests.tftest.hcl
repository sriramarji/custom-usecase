# unit testing
run "name_validation" {
  command = plan

  assert {
    condition     = module.ec2.ec2_instance_tags["Name"] == "${var.name}"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}