# # #
# Start -- refactored resource names to be less redundant
# # #

moved {
  from = google_cloud_tasks_queue.task_queue
  to   = google_cloud_tasks_queue.main
}

moved {
  from = google_project_iam_member.github_actions_service_account_roles
  to   = google_project_iam_member.github_actions
}

moved {
  from = google_project_iam_member.opentofu_roles
  to   = google_project_iam_member.opentofu
}

moved {
  from = google_service_account.github_actions_service_account
  to   = google_service_account.github_actions
}

moved {
  from = google_sql_database.database
  to   = google_sql_database.main
}

moved {
  from = google_sql_user.appengine_user
  to   = google_sql_user.appengine
}

# # #
# End --- refactored resource names to be less redundant
# # #
