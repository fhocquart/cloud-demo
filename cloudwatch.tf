# Create a CloudWatch metric alarm to scale out when CPU utilization is high
resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name                = "cloud-demo-scale-out-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_actions             = [aws_autoscaling_policy.scale_out.arn]  # Action to scale out
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  tags = {
    Name = "cloud-demo-scale-out-alarm"
  }
}

# Create a CloudWatch metric alarm to scale in when CPU utilization is low
resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name                = "cloud-demo-scale-in-alarm"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_actions             = [aws_autoscaling_policy.scale_in.arn]  # Action to scale in
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  tags = {
    Name = "cloud-demo-scale-in-alarm"
  }
}
