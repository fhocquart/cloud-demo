# Create an Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "cloud-demo-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Name = "cloud-demo-lb"
  }
}

# Create a target group for the load balancer
resource "aws_lb_target_group" "app_tg" {
  name     = "cloud-demo-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "cloud-demo-tg"
  }
}

# Create a listener for the load balancer
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# # Attach the Auto Scaling group to the target group
# resource "aws_lb_listener" "example" {
#   load_balancer_arn = aws_lb.example.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.example.arn  # This might be incorrect depending on the context
#   }
# }
