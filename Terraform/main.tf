resource "aws_instance" "instance" {
  count = var.instance_count
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name = var.key_name
  security_groups = [
    var.sec_group_name,
  ]
  tags = {
        Name = "Terraform ${count.index + 1}"
        Batch = "5AM"
  }
  volume_tags = var.volume_tags
  vpc_security_group_ids = [
    aws_security_group.instance.id,
  ]
  root_block_device {
    volume_size = var.volume_size
  }
}

resource "aws_security_group" "instance" {
  description = var.sec_group_description
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]
  ingress = [
    for _port in var.port_list:
    {
      cidr_blocks = [
      for _ip in var.ip_list:
      _ip
      ]
      description = ""
      from_port = _port
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = _port
    }
  ]
  name = var.sec_group_name
}
