# ============================================================================
# Complete VPC Example
# Production-grade VPC with all features enabled
# ============================================================================

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../modules/vpc"

  name     = "production"
  vpc_cidr = "10.0.0.0/16"
  az_count = 3

  enable_nat_gateway = true
  single_nat_gateway = false  # HA: one NAT per AZ
  enable_flow_logs   = true
  flow_logs_retention = 90

  tags = {
    Environment = "production"
    Terraform   = "true"
    Project     = "platform"
    ManagedBy   = "fufuizm"
  }
}

# --------------- Outputs ---------------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "nat_ips" {
  value = module.vpc.nat_gateway_ips
}
