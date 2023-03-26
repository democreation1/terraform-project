#this file consists of code for instances and sg

provider "aws" {
region = "ap-south-1"
access_key = "AKIAZGSXM54VLGE5KPDU"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0d81306eddc614a45"
  instance_type   = "t2.micro"
  key_name        = "mumbaikp"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
  
sudo -i
yum install httpd -y
systemctl start httpd 
chkconfig httpd on  #chkconfig means never stop the service...
echo "hai all this is my app created by terraform infrastructurte by HARSHITHA server-1" > /var/www/html/index.html
EOF         #End Of the File
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0d81306eddc614a45"
  instance_type   = "t2.micro"
  key_name        = "mumbaikp"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
  
#!/bin/bash
  
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by harshitha server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

#creating security group
resource "aws_security_group" "three" {
  name = "elb-sg"
  
  ingress {        #inbound
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    #Anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   #Anywhere
  }

  egress {   #outbound
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]     #Anywhere
  }
}

resource "aws_s3_bucket" "four" {
  bucket = "harshitha0077552bucketterra"
}


