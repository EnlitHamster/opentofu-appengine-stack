resource "google_sql_database_instance" "production" {
  project = local.config.project_id
  region  = local.config.location_id

  name             = "production-instance"
  database_version = "MYSQL_8_0"

  deletion_protection = true

  settings {
    tier                        = "db-f1-micro"
    edition                     = "ENTERPRISE"
    availability_type           = "ZONAL"
    deletion_protection_enabled = true
  }

  depends_on = [google_project_iam_member.opentofu]
}

resource "google_sql_database" "main" {
  name     = "appengine_db"
  instance = google_sql_database_instance.production.name
}

resource "google_sql_user" "appengine" {
  name     = "appengine_user"
  instance = google_sql_database_instance.production.name
  host     = "%"
  password = google_secret_manager_secret_version.database_user_password.secret_data
}