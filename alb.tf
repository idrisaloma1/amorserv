/** resource "aws_security_group" "alb_sg" {
  name        = "amorserv_alb_sg"
  description = "Security group for AmorServ ALB"
  vpc_id      = aws_vpc.amorserv_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "amorserv_alb_sg"
  }
}

resource "aws_lb" "amorserv_alb" {
  name               = "amorserv-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.amorserv_subnets[*].id

  tags = {
    Name = "amorserv-alb"
  }
}

resource "aws_lb_target_group" "amorserv_tg" {
  name     = "amorserv-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.amorserv_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "amorserv-tg"
  }
}

resource "aws_lb_listener" "amorserv_listener" {
  load_balancer_arn = aws_lb.amorserv_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.amorserv_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "amorserv_tg_attachment" {
  target_group_arn = aws_lb_target_group.amorserv_tg.arn
  target_id        = "<TARGET_INSTANCE_ID>" # Replace with actual target instance ID
  port             = 80
}
**/