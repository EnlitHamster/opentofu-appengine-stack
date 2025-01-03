resource "google_cloud_tasks_queue" "main" {
  name     = "task-queue"
  location = "europe-west1"

  rate_limits {
    max_concurrent_dispatches = 1
    max_dispatches_per_second = 1
  }

  retry_config {
    max_attempts       = 3
    max_retry_duration = "3s"
  }

  depends_on = [google_project_iam_member.opentofu]
}
