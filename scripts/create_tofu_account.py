import subprocess
import utils


def run(config: utils.ProjFig = utils.ProjFig()) -> None:
    commands = (
        f'gcloud iam service-accounts create {config.service_account_name}',
        f'gcloud projects add-iam-policy-binding {config.project_id} --member="serviceAccount:{config.full_service_account_name}" --role="roles/editor"',
        f'gcloud projects add-iam-policy-binding {config.project_id} --member="serviceAccount:{config.full_service_account_name}" --role="roles/resourcemanager.projectIamAdmin"',
        f'gcloud iam service-accounts keys create {config.service_account_key_file} --iam-account="{config.full_service_account_name}"',
    )

    for command in commands:
        subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
