   terraform {
     backend "s3" {
       bucket       = "eks-platform-tfstate-940702769327"
       key          = "dev/terraform.tfstate"
       region       = "eu-west-2"
       use_lockfile = true
       encrypt      = true
     }
   }