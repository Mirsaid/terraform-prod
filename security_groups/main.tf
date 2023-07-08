#Security Groups 
resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "bastion_sg" {
  name   = "bastion_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "efs_sg" {
  name   = "efs_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "eic_endpoint_sg" {
  name   = "eic_endpoint_sg"
  vpc_id = var.vpc_id
}



#Security Group Rules

#EC2 Security Group Rules
resource "aws_security_group_rule" "ingress_ec2_ssh_traffic" {
  type = "ingress"
  #type                     = "SSH from bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.eic_endpoint_sg.id
  # tags = {
  #   Name = "EC2 ingress ssh traffic"
  # }
}

# resource "aws_security_group_rule" "ingress_ec2_icmp_traffic" {
#   type        = "ingress"
#   from_port   = -1
#   to_port     = -1
#   protocol    = "icmp"
#   security_group_id = aws_security_group.ec2_sg.id
#   source_security_group_id = aws_security_group.eic_endpoint_sg.id
#   # tags = {
#   #   Name = "EC2 ingress icmp traffic"
#   # }
# }


resource "aws_security_group_rule" "ingress_ec2_efs_traffic" {
  type              = "ingress"
  from_port         = -1 #2049
  to_port           = -1 #2049
  protocol          = "all"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["10.0.0.0/16"]
  # tags = {
  #   Name = "EC2 ingress EFS traffic"
  # }
}


resource "aws_security_group_rule" "egress_ec2_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all" #need to change and give more specific permissions
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  # tags = {
  #   Name = "EC2 egress traffic"
  # }
}


#EFS Security Group Rules
resource "aws_security_group_rule" "ingress_efs_vpc_traffic" {
  type              = "ingress"
  from_port         = -1    #2049
  to_port           = -1    #2049
  protocol          = "all" #need to change and give more specific permissions
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["10.0.0.0/16"]
  # tags = {
  #   Name = "EFS ingress traffic"
  # }
}

resource "aws_security_group_rule" "egress_efs_vpc_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all" #need to change and give more specific permissions
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["10.0.0.0/16"]
  # tags = {
  #   Name = "EFS egress traffic"
  # }
}

#Bastion Security Group Rules
# resource "aws_security_group_rule" "ingress_bastion_sg_traffic" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.bastion_sg.id
#   cidr_blocks              = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "egress_bastion_sg_traffic" {
#   type                     = "egress"
#   from_port                = -1
#   to_port                  = -1
#   protocol                 = "all"
#   security_group_id        = aws_security_group.bastion_sg.id
#   cidr_blocks              = ["0.0.0.0/0"]
#   # tags = {
#   #   Name = "Bastion egress traffic"
#   # }
# }

#RDS Security Group Rules
resource "aws_security_group_rule" "ingress_rds_ssh_traffic" {
  type = "ingress"
  #type                     = "SSH from bastion"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.eic_endpoint_sg.id

}

#need to change and give more specific permissions or delete
resource "aws_security_group_rule" "ingress_rds_efs_traffic" {
  type              = "ingress"
  from_port         = -1 #2049
  to_port           = -1 #2049
  protocol          = "all"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["10.0.0.0/16"]

}


resource "aws_security_group_rule" "egress_rds_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all" #need to change and give more specific permissions
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]

}

#EIC Endpoint Security Group Rules

# resource "aws_security_group_rule" "ingress_eip_endpoint_traffic" {
#   type                     = "ingress"
#   from_port                = -1 #2049
#   to_port                  = -1 #2049
#   protocol                 = "all"
#   security_group_id        = aws_security_group.rds_sg.id
#   cidr_blocks = ["10.0.0.0/16"]

# }


resource "aws_security_group_rule" "egress_eip_endpoint_ssh_traffic" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP" #need to change and give more specific permissions
  security_group_id        = aws_security_group.eic_endpoint_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "egress_eip_endpoint_mysql_traffic" {
  type                     = "egress"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "TCP" #need to change and give more specific permissions
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id        = aws_security_group.eic_endpoint_sg.id
}