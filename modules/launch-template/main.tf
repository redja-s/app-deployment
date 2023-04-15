resource "aws_launch_template" "test_launch_template" {
  name          = var.launch_template_name
  instance_type = var.instance_type
  image_id      = var.ami_id

  user_data = filebase64("${path.module}/user-data/bootstrap.sh")
}