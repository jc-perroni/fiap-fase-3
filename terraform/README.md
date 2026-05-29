# Terraform — Infraestrutura AWS (Fase 3)

Projeto Terraform modular que provisiona toda a infraestrutura AWS da aplicação Feature Flags.

## Recursos provisionados

| Módulo         | Recurso               | Detalhe                                                   |
| -------------- | --------------------- | --------------------------------------------------------- |
| **networking** | VPC                   | `10.0.0.0/16`                                             |
|                | Subnets Públicas      | 2 subnets (uma por AZ) — ELB / Ingress                    |
|                | Subnets Privadas      | 2 subnets (uma por AZ) — EKS nodes, RDS, Redis            |
|                | Internet Gateway      | Saída para internet das subnets públicas                  |
|                | NAT Gateway + EIP     | Saída para internet das subnets privadas                  |
|                | Route Tables          | Pública (→ IGW) e Privada (→ NAT)                         |
| **eks**        | Cluster EKS           | Kubernetes 1.31 com LabRole                               |
|                | Node Group            | `t3.medium`, 2 nodes (min 1 / max 4)                      |
| **databases**  | RDS auth-service      | PostgreSQL 15 — `auth_db`                                 |
|                | RDS flag-service      | PostgreSQL 15 — `flags_db`                                |
|                | RDS targeting-service | PostgreSQL 15 — `targeting_db`                            |
|                | ElastiCache Redis     | Redis 7.0, `cache.t3.micro`                               |
|                | DynamoDB              | `ToggleMasterAnalytics` — PAY_PER_REQUEST                 |
| **messaging**  | SQS                   | `feature-flags-evaluation-sqs`                            |
| **ecr**        | ECR ×5                | `pos2/{auth,flag,targeting,evaluation,analytics}-service` |

## Pré-requisitos

- Terraform >= 1.10
- AWS CLI configurado (`aws configure`)
- Credenciais do AWS Academy ativas

## Passo a passo

### 1. Criar o bucket S3 para o state remoto

```bash
BUCKET_NAME="fiap-terraform-state-$(aws sts get-caller-identity --query Account --output text)"

aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region us-east-1

aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled
```

### 2. Atualizar o backend.tf

Edite [backend.tf](backend.tf) e substitua o valor de `bucket`:

```hcl
backend "s3" {
  bucket       = "fiap-terraform-state-653509254250"  # ← seu bucket
  key          = "fase03/terraform.tfstate"
  region       = "us-east-1"
  use_lockfile = true
}
```

### 3. Definir a senha do banco

```bash
export TF_VAR_db_password="sua_senha_aqui"
```

### 4. Inicializar e aplicar

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### 5. Configurar o kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name feature-flags-eks
kubectl get nodes
```

## Estrutura dos módulos

```
terraform/
├── backend.tf          # Backend remoto S3 + versão requerida
├── main.tf             # Provider + chamadas aos módulos
├── variables.tf        # Variáveis raiz
├── outputs.tf          # Outputs consolidados
├── terraform.tfvars    # Valores não-sensíveis
└── modules/
    ├── networking/     # VPC, subnets, IGW, NAT, route tables
    ├── eks/            # Cluster EKS + node group (LabRole)
    ├── databases/      # RDS ×3, ElastiCache Redis, DynamoDB
    ├── messaging/      # Fila SQS
    └── ecr/            # 5 repositórios ECR
```

## Observações sobre o LabRole (AWS Academy)

O AWS Academy não permite criar roles IAM customizadas. Por isso, o `LabRole`
é usado tanto para o plano de controle do EKS quanto para os worker nodes.
O ARN é calculado automaticamente a partir da conta corrente:

```
arn:aws:iam::<ACCOUNT_ID>:role/LabRole
```

## Destruir a infraestrutura

```bash
terraform destroy
```

> **Atenção:** o comando acima remove todos os recursos, incluindo os bancos de dados.
