variable "project_name" {
  description = "Nome do projeto (usado nas tags)"
  type        = string
}

variable "repository_names" {
  description = "Lista de nomes dos repositórios ECR a criar"
  type        = list(string)
}
