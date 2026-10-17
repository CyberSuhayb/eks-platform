   variable "name" {
     description = "Name prefix for all VPC resources"
     type        = string
   }

   variable "cidr_block" {
     description = "CIDR block for the VPC"
     type        = string
   }

   variable "azs" {
     description = "Availability zones to use"
     type        = list(string)
   }

   variable "public_subnet_cidrs" {
     description = "CIDR blocks for public subnets (one per AZ)"
     type        = list(string)
   }

   variable "private_subnet_cidrs" {
     description = "CIDR blocks for private subnets (one per AZ)"
     type        = list(string)
   }