output "workspacte_region" {
  value = lookup(var.aws_region, local.env)
}

output "workspace_select" {
  value = local.env
}