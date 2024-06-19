resource "aws_lb_target_group" "TG1" {
  name     = "TG1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vm-vpc.id
}

resource "aws_lb_target_group_attachment" "TGA" {
  target_group_arn = aws_lb_target_group.TG1.arn
  target_id        = aws_instance.vm12[0].id
  port             = 80
}

resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-07bc7161aecbfbe53"]
  subnets            = ["subnet-0ac08e9a0bfca52d0","subnet-0a1bbba8395103c32"]

}

resource "aws_lb_listener" "ALBL" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG1.arn
  }
}