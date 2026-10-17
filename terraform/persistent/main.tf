   terraform {
     required_version = ">= 1.10"
     required_providers {
       aws = { source = "hashicorp/aws", version = "~> 6.0" }
     }
     backend "s3" {
       bucket       = "eks-platform-tfstate-940702769327"
       key          = "persistent/terraform.tfstate"
       region       = "eu-west-2"
       use_lockfile = true
       encrypt      = true
     }
   }

   provider "aws" {
     region = "eu-west-2"
     default_tags { tags = { Project = "eks-platform", ManagedBy = "terraform" } }
   }

   resource "aws_ecr_repository" "app" {
     name                 = "eks-platform-app"
     image_tag_mutability = "IMMUTABLE"
     image_scanning_configuration { scan_on_push = true }
     encryption_configuration { encryption_type = "AES256" }
   }

   resource "aws_ecr_lifecycle_policy" "app" {
     repository = aws_ecr_repository.app.name
     policy = jsonencode({
       rules = [{
         rulePriority = 1
         description  = "Keep last 3 images"
         selection    = { tagStatus = "any", countType = "imageCountMoreThan", countNumber = 3 }
         action       = { type = "expire" }
       }]
     })
   }

   output "ecr_url" { value = aws_ecr_repository.app.repository_url }