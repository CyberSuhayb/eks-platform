variable "admin_cidr" {
  description = "Your public IP in CIDR form, allowed to reach the EKS API (set in terraform.tfvars, not committed)"
  type        = string
}