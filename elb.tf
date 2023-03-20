resource "aws_elb" "bar" {
  name               = "harshii-terraform-elb"
  availability_zones = ["ap-south-1a", "ap-south-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2  #this is ntg but if we connected to both the servers without any interrupotion then it is healty
    unhealthy_threshold = 2  #this is ntg but if we send 2rqsts and we don't get connected to website then it is unhealthy 
    timeout             = 5  #this is ntg but if we don't get the rqst from server in 5sec then it is time out
    target              = "HTTP:80/"
    interval            = 30 #the time gap b/w the health checks
  }
    
  #we have created loadbalancer and we need to create instance for it
  instances                 = ["${aws_instance.one.id}", "${aws_instance.two.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 400
  tags = {
    Name = "raham-tf-elb"
  }
}
