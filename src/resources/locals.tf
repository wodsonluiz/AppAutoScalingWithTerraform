locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }
 

  common_tags = {
    Project   = "Projeto Piloto para prover recursos via Terraform [BancoModal]"
    CreatedAt = "2021-06-16"
    ManagedBy = "Terraform"
    Owner     = "Wodson Luiz"
    Service   = "Auto Scaling App"
  }
}