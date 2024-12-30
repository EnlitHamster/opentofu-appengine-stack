# OpenTofu App Engine Stack

This repository details my experiments with OpenTofu and GCP to provision an App Engine stack based on a GitHub repo, with a CI/CD pipeline that includes Cloud Build, and data stored in Cloud Storage and Cloud SQL, complete with logging and monitoring.

The deployed app is developed in [a separate repository](https://github.com/EnlitHamster/example-appengine) that is connected as a v2 repository to Cloud Build via the OpenTofu declaration. A reference to the project is stored here as a submodule.