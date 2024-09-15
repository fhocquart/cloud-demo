# Launch configuration for the Auto Scaling group
resource "aws_launch_configuration" "app_launch_configuration" {
  name          = "cloud-demo-launch-configuration"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "CM_keypair"

  security_groups = [aws_security_group.public_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling group
resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app_launch_configuration.id
  vpc_zone_identifier  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]  # Subnets for the ASG
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  health_check_type    = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "cloud-demo-instance"
    propagate_at_launch = true
  }

  # Ensure the instances in the ASG can receive traffic from the load balancer
  depends_on = [aws_launch_configuration.app_launch_configuration]
}

# Auto Scaling policy to scale out
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

# Auto Scaling policy to scale in
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}
