module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}


module "igw" {
  source = "./igw"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source              = "./nat"
  public_subnet_1a_id = module.subnets.public_subnet_1a_id
  igw_id              = module.igw.igw_id
  depends_on          = [module.igw]
}

module "routes" {
  source                    = "./routes"
  vpc_id                    = module.vpc.vpc_id
  private_subnet_1a_ec2_id  = module.subnets.private_subnet_1a_ec2_id
  private_eu_central_1a_rds_id = module.subnets.private_eu_central_1a_rds_id
  private_eu_central_1b_rds_id = module.subnets.private_eu_central_1b_rds_id
  public_subnet_1a_id       = module.subnets.public_subnet_1a_id
  nat_gw_id                 = module.nat.nat_gw_id
  igw_id                    = module.igw.igw_id
  vpc_endpoint_id           = module.vpc_endpoint.vpc_endpoint_id
}


module "ec2_server" {
  source                   = "./ec2_server"
  vpc_id                   = module.vpc.vpc_id
  private_subnet_1a_ec2_id = module.subnets.private_subnet_1a_ec2_id
  ec2_sg_id                = module.security_groups.ec2_sg_id
  efs_dns_name             = module.efs.efs_dns_name
  depends_on               = [module.efs]
  ec2_s3_access_role       = module.iam.ec2_s3_access_role
  #key_name = module.key_pair.key_name

}

module "rds" {
  source                   = "./rds"
  rds_subnet_group_id = module.subnets.rds_subnet_group_id
  private_eu_central_1a_rds_id = module.subnets.private_eu_central_1a_rds_id
  private_eu_central_1b_rds_id = module.subnets.private_eu_central_1b_rds_id
  rds_sg_id                = module.security_groups.rds_sg_id
  vpc_id                   = module.vpc.vpc_id
}

# module "bastion_host" {
#   source              = "./bastion_host"
#   vpc_id              = module.vpc.vpc_id
#   public_subnet_1a_id = module.subnets.public_subnet_1a_id
#   bastion_sg_id       = module.security_groups.bastion_sg_id
#   #key_name = module.key_pair.key_name
#   ec2_server_private_ip = module.ec2_server.ec2_server_private_ip
#   depends_on            = [module.ec2_server, module.ansible]
# }

module "ansible" {
  source                = "./ansible"
  ec2_server_private_ip = module.ec2_server.ec2_server_private_ip
  depends_on            = [module.ec2_server]
  #key_name = module.key_pair.key_name
}



module "efs" {
  source                   = "./efs"
  efs_sg_id                = module.security_groups.efs_sg_id
  private_subnet_1a_ec2_id = module.subnets.private_subnet_1a_ec2_id
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
  eip_ip = module.nat.eip_ip
}

module "iam" {
  source = "./iam"
  bucket_name = module.s3.bucket_name

}

module "s3" {
  source = "./s3"

}

module "vpc_endpoint" {
  source = "./vpc_endpoint"
  vpc_id = module.vpc.vpc_id
  #private_sub_endpoint_gw_id = module.routes.private_sub_endpoint_gw_id
}

# module "backups" {
#   source = "./backups"
#   example_aws_backup_service_role_arn = module.iam.example_aws_backup_service_role_arn
# }

# module "key_pair" {
#     source = "./key_pair"
# }
#  output "vpc" {
#    value = module.vpc.vpc_id
#  }
# output "public_subnet_1a_id" {
#    value = module.subnets.public_subnet_1a_id
# }

# output "bastion_host_public_ip" {
#   value = module.bastion_host.bastion_host_public_ip

# }

output "ec2_server_private_ip" {
  value = module.ec2_server.ec2_server_private_ip

}

output "password" {
  value = module.iam.password
  sensitive = true
}


# output "ec2_server_2_private_ip" {
#   value = module.ec2_server.ec2_server_2_private_ip

# }

# output "private_key"{ 
#   value = module.key_pair.private_key
#   sensitive = true
# }




# module "rds" {
#   source                  = "./rds"
#   vpc_id                  = module.vpc.vpc_id
#   public_subnet_1a_id     = module.subnets.public_subnet_1a_id
#   public_subnet_1b_id     = module.subnets.public_subnet_1b_id
#   private_subnet_1a_id    = module.subnets.private_subnet_1a_id
#   private_subnet_1b_id    = module.subnets.private_subnet_1b_id
#   nat_gw_id          = module.nat.nat_gw_id
#   igw_id                  = module.igw.igw_id
#   db_subnet_group_name    = "db_subnet_group"
#   db_name                 = "mydb"
#   db_username             = "myuser"
#   db_password             = "mypassword"
#   db_port                 = "3306"
#   db_instance_class       = "db.t2.micro"
#   db_engine               = "mysql"
#   db_engine_version       = "5.7.22"
#   db_allocated_storage    = "20"
#   db_storage_type         = "gp2"
#   db_multi_az             = "false"
#   db_backup_retention     = "5"
#   db_backup_window        = "07:00-09:00"
#   db_maintenance_window   = "Mon:03:00-Mon:04:00"
#   db_parameter_group_name = "default.mysql5.7"
#   db_publicly_accessible  = "false"
#   db_auto_minor_version_upgrade = "true"
#   db_vpc_security_group_ids = [module.security_groups.rds_sg_id]
#   db_subnet_ids           = [module.subnets.private_subnet_1a_id, module.subnets.private_subnet_1b_id]
# }


# output "alb_dns_name" {
#   value = module.alb.alb_dns_name
# }


# output "autoscaling_group_name" {
#   value = module.autoscaling.autoscaling_group_name
# }



# module "autoscaling" {
#   source      = "./autoscaling"
#   vpc_id      = module.vpc.vpc_id
#   subnet_ids  = module.subnets.private_subnet_ids
# }

# module "alb" {
#   source      = "./alb"
#   subnet_ids  = module.subnets.private_subnet_id
# }

