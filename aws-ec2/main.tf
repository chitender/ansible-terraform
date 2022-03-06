#AWS Instance
resource "aws_instance" "instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    associate_public_ip_address = var.associate_public_ip_address 
    subnet_id = var.subnet_id
    root_block_device {
      volume_size           = "${var.EC2_ROOT_VOLUME_SIZE}"
      volume_type           = "${var.EC2_ROOT_VOLUME_TYPE}"
      delete_on_termination = "${var.EC2_ROOT_VOLUME_DELETE_ON_TERMINATION}"
      encrypted             = var.EC2_ROOT_VOLUME_ENCRYPT
      tags = merge(
        var.default_tags,
        {
        Name = "RootVolume"
        }
      )
  }
    ebs_block_device {
      device_name           = var.EC2_DATA_DEVICE_NAME
      volume_size           = var.EC2_DATA_VOLUME_SIZE
      volume_type           = var.EC2_DATA_VOLUME_TYPE
      encrypted             = var.EC2_DATA_VOLUME_ENCRYPT
      delete_on_termination = var.EC2_DATA_VOLUME_DELETE_ON_TERMINATION
      tags = merge(
        var.default_tags,
        {
        Name = "DataVolume"
        }
      )
  }
  key_name   = var.key_name
  lifecycle {
    ignore_changes = [ami]
  }
  security_groups = var.security_groups_id 
  tags = merge(
    var.default_tags,
    {
     Name = "MyTestInstance"
    }
  )
  
}

#AMI Filter for Ubuntu 18
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



#Cloudwatch Metric

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2" 
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80" 
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
        InstanceId = aws_instance.instance.id
      }
}