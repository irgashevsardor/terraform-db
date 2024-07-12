output "db_hostname" {
  description = "DB instance hostname"
  value       = aws_db_instance.mysql_db.address
}

output "db_port" {
  description = "DB port"
  value       = aws_db_instance.mysql_db.port
}

output "db_username" {
  description = "DB username"
  value       = aws_db_instance.mysql_db.username
}
