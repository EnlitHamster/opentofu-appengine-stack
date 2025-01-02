# The App Engine should always be manually created, as it cannot be deleted, thus
# makes it really hard to automatically provision.
import {
  to = google_app_engine_application.app
  id = local.config.project_id
}

resource "google_app_engine_application" "app" {
  project = local.config.project_id
  location_id = local.config.app_engine_location_id
}