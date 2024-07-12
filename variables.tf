variable "db_name" {
  description = "DB name"
  type        = string
  default     = "db"
}

variable "db_allocated_storage" {
  description = "DB allocated storage"
  type = number
  default = 5
}