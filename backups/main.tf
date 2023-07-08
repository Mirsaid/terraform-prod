locals {
  backups = {
    schedule  = "cron(15 14 ? * MON-FRI *)" /* UTC Time */
    retention = 1 // days
  }
}

resource "aws_backup_vault" "example-backup-vault" {
  name = "example-backup-vault"
  tags = {
    Role    = "backup-vault"
  }
}

resource "aws_backup_plan" "example-backup-plan" {
  name = "example-backup-plan"

  rule {
    rule_name         = "weekdays-every-2-hours-${local.backups.retention}-day-retention"
    target_vault_name = aws_backup_vault.example-backup-vault.name
    schedule          = local.backups.schedule
    start_window      = 60
    completion_window = 300

    lifecycle {
      delete_after = local.backups.retention
    }

    recovery_point_tags = {
      Role    = "backup"
      Creator = "aws-backups"
    }
  }

  tags = {
    Role    = "backup"
  }
}

resource "aws_backup_selection" "example-server-backup-selection" {
  iam_role_arn = var.example_aws_backup_service_role_arn
  name         = "example-server-resources"
  plan_id      = aws_backup_plan.example-backup-plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

