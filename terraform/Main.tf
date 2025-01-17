# Fetch the default VPC in the AWS account
data "aws_vpc" "this" {
  default = true
}

# Fetch the first two available subnets within the selected VPC
data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

# Security Group to allow HTTP and SSH access
resource "aws_security_group" "web_secg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic from the internet"
  vpc_id      = data.aws_vpc.this.id

  # Allow incoming HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming SSH access (consider restricting this to a trusted IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to a specific IP for security (["your_ip/32"])
  }

  # Allow all outbound traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define a Launch Template for EC2 instances
resource "aws_launch_template" "web_lunt" {
  name          = "web-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(file("${path.module}/userdata.sh"))


  # Attach security group to the instances
  network_interfaces {
    security_groups = [aws_security_group.web_secg.id]
  }
}

# Auto Scaling Group to distribute instances across two subnets
resource "aws_autoscaling_group" "web_autosg" {
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.min_size
  vpc_zone_identifier = slice(data.aws_subnets.this.ids, 0, 2)

  launch_template {
    id = aws_launch_template.web_lunt.id
  }

  # Assign a Name tag to instances launched by the ASG
  tag {
    key                 = "Name"
    value               = "web-server"
    propagate_at_launch = true
  }
  depends_on = [ aws_launch_template.web_lunt ]
}
