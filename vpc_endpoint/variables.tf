variable "vpc_id" {
    description = "The ID of the VPC"
}
variable "service_name" {
    description = "The name of the service"
    default    = "com.amazonaws.s3"
}

variable "region" {
    description = "The region to deploy to"
    default     = "eu-central-1"
}

# variable "private_sub_endpoint_gw_id"{  
#     description = "The ID of the private sub endpoint gateway"
# }