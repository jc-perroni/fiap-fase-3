# ─── Security Group — RDS PostgreSQL ─────────────────────────────────────────
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Permite acesso PostgreSQL apenas de dentro da VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL de dentro da VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-rds-sg"
    Environment = var.environment
  }
}

# ─── Security Group — ElastiCache Redis ──────────────────────────────────────
resource "aws_security_group" "elasticache" {
  name        = "${var.project_name}-elasticache-sg"
  description = "Permite acesso Redis apenas de dentro da VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "Redis de dentro da VPC"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-elasticache-sg"
    Environment = var.environment
  }
}

# ─── Subnet Group — RDS ───────────────────────────────────────────────────────
resource "aws_db_subnet_group" "main" {
  name        = "${var.project_name}-db-subnet-group"
  description = "Subnet group para instâncias RDS nas subnets privadas"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

# ─── RDS PostgreSQL — auth-service ───────────────────────────────────────────
resource "aws_db_instance" "auth" {
  identifier        = "${var.project_name}-auth-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "auth_db"
  username = "postgres"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0

  tags = {
    Name        = "${var.project_name}-auth-db"
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [engine_version, password]
  }
}

# ─── RDS PostgreSQL — flag-service ───────────────────────────────────────────
resource "aws_db_instance" "flag" {
  identifier        = "${var.project_name}-flag-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "flags_db"
  username = "postgres"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0

  tags = {
    Name        = "${var.project_name}-flag-db"
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [engine_version, password]
  }
}

# ─── RDS PostgreSQL — targeting-service ───────────────────────────────────────
resource "aws_db_instance" "targeting" {
  identifier        = "${var.project_name}-targeting-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "targeting_db"
  username = "postgres"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible     = false
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0

  tags = {
    Name        = "${var.project_name}-targeting-db"
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [engine_version, password]
  }
}

# ─── Subnet Group — ElastiCache ──────────────────────────────────────────────
resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.project_name}-cache-subnet-group"
  description = "Subnet group para ElastiCache Redis nas subnets privadas"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-cache-subnet-group"
    Environment = var.environment
  }
}

# ─── ElastiCache — Redis Cluster ──────────────────────────────────────────────
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project_name}-cache"
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = var.cache_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [aws_security_group.elasticache.id]

  tags = {
    Name        = "${var.project_name}-cache"
    Environment = var.environment
  }
}

# ─── DynamoDB — ToggleMasterAnalytics ─────────────────────────────────────────
resource "aws_dynamodb_table" "analytics" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "flagId"
  range_key    = "timestamp"

  attribute {
    name = "flagId"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  # GSI para consultas por evento
  global_secondary_index {
    name            = "timestamp-index"
    hash_key        = "timestamp"
    projection_type = "ALL"
  }

  tags = {
    Name        = var.dynamodb_table_name
    Environment = var.environment
  }
}
